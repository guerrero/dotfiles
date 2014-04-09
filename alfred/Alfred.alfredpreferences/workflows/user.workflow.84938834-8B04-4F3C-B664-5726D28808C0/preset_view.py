from uuid import uuid4
import os
import alfred
import node_cache
import config
import preset_manager
from os.path import splitext



def create_add_arg(node):
    return "add:" + node.type_name

def creat_node_arg(preset_node):
    return "node:" + preset_node['id']

def generate_view(path, query):

    preset = preset_manager.load_preset(path)
    feedback = []


    # if we have to filter out the add new nodes,
    # do it first so that it is easy to add
    if query is not None and len(query) > 0:
        for node_type, node in node_cache.node_cache.iteritems():
            if node.display_name.lower().find(query.lower()) >= 0:
                feedback.append(alfred.item(
                    title=node.display_name,
                    subtitle="quick add",
                    arg=create_add_arg(node),
                    valid='yes',
                    icon='icons/add.png'
                ))

    # preset name
    preset_folder, preset_file = os.path.split(path)
    feedback.append(alfred.item(title=preset_file, subtitle="Preset file name", arg=path, icon='icons/preset.png'))

    # preset nodes
    if len(preset) == 0:
        feedback.append(alfred.item(title="No steps",subtitle="Add a step from below"))
    else:
        for i, preset_node in enumerate(preset):
            node = node_cache.get_target(preset_node['type'])
            subtitle = node.display_name
            title = "{0}: ".format(i+1) + node.get_summary(preset_node['node_action'])
            feedback.append(alfred.item(
                title=title,
                subtitle=subtitle,
                arg=creat_node_arg(preset_node),
                valid='yes',
                icon=node.icon
            ))


    # Filtered items are listed at the beginning for
    # quick access
    if query is None or not len(query) > 0:
        # display all
        # add new nodes
        nodes = []
        for node_type, node in node_cache.node_cache.iteritems():
            nodes.append(node)
        for node in sorted(nodes,key=lambda x:x.display_name):
            feedback.append(alfred.item(
                title=node.display_name,
                subtitle=node.help_text,
                arg=create_add_arg(node),
                valid='yes',
                icon='icons/add.png'
            ))

    # Cancel
    feedback.append(alfred.item(title="Cancel",valid="yes",arg="cancel:",icon="icons/cancel.png"))

    alfred.write(alfred.xml(feedback))



def main():
    command, query = alfred.args2()
    path = config.get( config.KEY_PRESET_VIEWING)
    if path is None or not os.path.exists(path):
        alfred.show('.list ')
        return
    generate_view(path, query)


if __name__ == '__main__':
    main()