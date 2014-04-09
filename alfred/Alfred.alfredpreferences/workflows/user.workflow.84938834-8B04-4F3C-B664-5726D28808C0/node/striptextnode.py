from core import Node

class StripTextNode(Node):

    def __init__(self):
        super(StripTextNode,self).__init__('node_striptext',"Strip text", 'Remove x characters', 'icons/striptext.png')


    def get_choices(self):
        return {
            # Where should the text be changed
            'from': {
                'display': 'remove from: ',
                'values': ['begin', 'end']
            }
        }

    def process(self, node_action, original_file, transform_text, state):
        try:
            remove_count = abs(int(node_action['text']))
        except:
            remove_count = 0

        if remove_count == 0:
            return transform_text, state

        base, name, ext = self.get_file_info(transform_text)

        if remove_count >= len(name):
            remove_count = len(name)

        at_start = node_action['choices']['from'] == 'begin'
        if at_start:
            name = name[remove_count:]
        else:
            name = name[:-remove_count]

        return self.get_transformed_filename(base,name,ext), state

    def get_summary(self, node_action, sample_text=None):
        try:
            remove_count =  abs(int(node_action['text']))
        except:
            remove_count = 0
        at_start = node_action['choices']['from'] == 'begin'
        if at_start:
            return "remove %d characters from beginning" % remove_count
        else:
            return "remove %d characters from end" % remove_count
