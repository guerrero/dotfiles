from core import Node

class TextNode(Node):

    def __init__(self):
        super(TextNode,self).__init__('node_text', "Add text", 'Add a specified text to the filename', 'icons/text.png')

    def get_choices(self):
        return {
            # Where should the text be changed
            'at': {
                'display': 'add at: ',
                'values': ['start', 'end']
            }
        }

    def process(self, node_action, original_file, transform_text, state):
        process_text = node_action['text']
        at_start = node_action['choices']['at'] == 'start'
        base, name, ext = self.get_file_info(transform_text)

        if at_start:
            name = process_text + name
        else:
            name = name + process_text

        return self.get_transformed_filename(base,name,ext), state

    def get_summary(self, node_action, sample_text=None):
        process_text = node_action['text']
        at_start = node_action['choices']['at'] == 'start'
        if at_start:
            return "add text '" + process_text + "' at start"
        else:
            return "add text '" + process_text + "' at end"
