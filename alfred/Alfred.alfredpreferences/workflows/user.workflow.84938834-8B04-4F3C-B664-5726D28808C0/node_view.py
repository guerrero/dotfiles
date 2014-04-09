from uuid import uuid4
import alfred
import node_cache
from os.path import splitext, split
import config
import preset_manager
import rename_view
import os


def generate_view(node, user_query):
    feedback = []

    # preview
    sample_files = ['sample_file0000.txt']
    selected_files = rename_view.get_finder_selection()
    if len(selected_files) > 0:
        sample_files = selected_files[:1]

    preset_node = node.get_preset_node(user_query)
    # main item
    title = node.get_summary(preset_node['node_action'], sample_files[0])
    feedback.append(alfred.item(
        title=title,
        subtitle=node.display_name,
        autocomplete=user_query,
        arg=user_query,
        valid='yes',
        icon=node.icon
    ))

    # first run the preset pipeline we already have in place
    # if we are adding a new node, run everything
    # else just run upto the node we are editing
    preset_path, preset = get_preset()
    node_id = get_current_node_id()
    modified_files = preset_manager.run_preset(preset, sample_files, until=node_id)
    modified_files = preset_manager.run_preset_node(node, preset_node, modified_files, sample_files)

    sample_files = [os.path.basename(f) for f in sample_files]
    modified_files = [os.path.basename(f) for f in modified_files]

    feedback.append(alfred.item(
        title=' '.join(modified_files),
        subtitle='Selected: '+' '.join(sample_files),
        autocomplete=user_query,
        icon='icons/preview.png'
    ))

    # choices
    for code, definition in node.get_choices().iteritems():
        # add each choice definition, active and autocomplete
        title = definition['display'] + node.get_active_choice(code, user_query)
        subtitle = 'Choose: '+', '.join(definition['values'])
        autocomplete = node.get_autocomplete_for_choice(code, user_query)
        feedback.append(alfred.item(title=title, subtitle=subtitle, autocomplete=autocomplete, icon='icons/choice.png'))

    # which step are we editing?
    step_count = len(preset)
    current_step = 0
    if node_id == '':
        step_count += 1
        current_step = str(step_count) + ' (new)'
    else:
        for i, preset_node in enumerate(preset):
            if preset_node['id'] == node_id:
                current_step = i+1
                break
    preset_folder, preset_file = split(preset_path)
    preset_file = splitext(preset_file)[0]

    feedback.append(alfred.item(
        title="Editing step {0} of {1}".format(current_step, step_count),
        subtitle=preset_file,
        icon='icons/preset.png',
        autocomplete=user_query
    ))

    feedback.append(alfred.item(title="Cancel", valid='yes', arg='cancel:',icon="icons/cancel.png"))

    alfred.write(alfred.xml(feedback))


def get_preset():
    preset_path = config.get(config.KEY_PRESET_VIEWING)
    preset = preset_manager.load_preset(preset_path)
    return (preset_path, preset)


def get_current_node_id():
    action = config.get(config.KEY_NODE_ACTION)
    if action.startswith("node:"):
        return action.replace("node:", "")
    else:
        return ''


def view(query):
    # figure out what we want
    action = config.get(config.KEY_NODE_ACTION)

    if action is None or action.startswith("cancel:"):
        alfred.show('.list ')
        return

    if action.startswith("add:"):
        # we are trying to add a new node
        node = node_cache.get_target(action.replace("add:", ''))
    elif action.startswith("node:"):
        node_id = action.replace("node:", "")
        # we are trying to edit an existing node
        # from the preset file
        preset_path, preset = get_preset()
        for preset_node in preset:
            if preset_node['id'] == node_id:
                node = node_cache.get_target(preset_node['type'])

    generate_view(node, query)


def prepare():
    action = config.get(config.KEY_NODE_ACTION)
    if action.startswith("cancel:"):
        alfred.show('.list ')
        return
    if action.startswith("node:"):
        node_id = action.replace("node:", "")
        # we are trying to edit an existing node
        # from the preset file
        preset_path, preset = get_preset()
        for preset_node in preset:
            if preset_node['id'] == node_id:
                node = node_cache.get_target(preset_node['type'])
                alfred.show('.node ' + node.get_query(preset_node['node_action']))
                return
    alfred.show('.node ')


def delete(query):
    action = config.get(config.KEY_NODE_ACTION)
    if action.startswith("node:"):
        node_id = action.replace("node:", "")
        # we are trying to edit an existing node
        # from the preset file
        preset_path, preset = get_preset()
        new_preset = [p for p in preset if p['id'] != node_id]
        preset_manager.save_preset(preset_path, new_preset)
    config.put(config.KEY_NODE_ACTION, None)
    alfred.show('.preset ')


def save(query):
    if not query.startswith('cancel:'):
        action = config.get(config.KEY_NODE_ACTION)
        preset_path, preset = get_preset()
        # adding a new node
        if action.startswith("add:"):
            node = node_cache.get_target(action.replace("add:", ''))
            preset_node = node.get_preset_node(query)
            # get the current preset
            preset.append(preset_node)
            preset_manager.save_preset(preset_path, preset)
        elif action.startswith("node:"):
            node_id = action.replace("node:", "")
            preset_path, preset = get_preset()
            for i, preset_node in enumerate(preset):
                if preset_node['id'] == node_id:
                    node = node_cache.get_target(preset_node['type'])
                    preset[i] = node.get_preset_node(query)
            preset_manager.save_preset(preset_path, preset)
        config.put(config.KEY_NODE_ACTION, None)
    alfred.show('.preset ')


def main():
    # --new type
    # --edit and id in the preset file
    command, query = alfred.args2()
    switch = {
        '--view': lambda x: view(x),
        '--save': lambda x: save(x),
        '--prepare': lambda x: prepare(),
        '--delete': lambda x: delete(x)
    }
    switch[command](query)


if __name__ == '__main__':
    main()
