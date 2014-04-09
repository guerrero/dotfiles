from os.path import exists, split, splitext
import os
import codecs
import json
import node_cache
import alfred


def load_preset(path):
    if not exists(path):
        with codecs.open(path, "w", "utf-8") as f:
            json.dump([], f, ensure_ascii=False, indent=1)
    with open(path, 'r') as f:
        preset = json.load(f)
    return preset


def save_preset(path, preset):
    with codecs.open(path, "w", "utf-8") as f:
        json.dump(preset, f, ensure_ascii=False, indent=1)


def get_preset_steps(preset):
    steps = []
    for preset_node in preset:
        node = node_cache.get_target(preset_node['type'])
        subtitle = node.display_name
        title = node.get_summary(preset_node['node_action'])
        steps.append('<b>'+subtitle+ "</b> " + title)
    return steps



def run_preset(preset, input_list, until=None):
    states = {}
    modified = []

    for line in input_list:
        mod_line = line
        for node_set in preset:
            if until is not None:
                if until==node_set['id']:
                    break
            node = node_cache.get_target(node_set['type'])
            _id = node_set['id']
            state = None
            if _id in states:
                state = states[_id]
            mod_line, state = node.process(node_set['node_action'], line, mod_line, state)
            states[_id] = state
        modified.append(mod_line)

    for i, m in enumerate(modified):
        modified[i] = m

    return modified

def run_preset_node(node, preset_node, input_list, original_list):
    states = {}
    modified = []
    for i, mod_line in enumerate(input_list):
        line = original_list[i]
        _id = preset_node['id']
        state = None
        if _id in states:
            state = states[_id]
        mod_line, state = node.process(preset_node['node_action'], line, mod_line, state)
        states[_id] = state
        modified.append(mod_line)
    for i, m in enumerate(modified):
        modified[i] = m
    return modified



def get_all_presets():
    presets = []
    # userdefined
    user_presets_folder = alfred._create(os.path.join(alfred.work(False), 'user_presets'))
    user_presets = [f for f in os.listdir(user_presets_folder) if f.endswith('.json')]
    sample_presets = [f for f in os.listdir('./samples') if f.endswith('.json')]

    for p in user_presets:
        presets.append(os.path.join(user_presets_folder, p))
    for p in sample_presets:
        presets.append(os.path.join('./samples', p))

    return presets