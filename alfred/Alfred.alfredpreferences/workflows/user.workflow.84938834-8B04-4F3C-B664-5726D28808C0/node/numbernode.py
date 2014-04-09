from core import Node

class NumberNode(Node):
    formats = {
        '1': "%d",
        '01': "%2d",
        '001': "%3d",
        '0001': "%4d"
    }

    def __init__(self):
        super(NumberNode,self).__init__('node_number', "Number sequence", 'Add a number sequence to the filename', 'icons/number.png')

    def get_choices(self):
        return {
            # Where should the text be changed
            'at': {
                'display': 'where: ',
                'values': ['end', 'begin']
            },
            'f':{
                'display': 'format: ',
                'values': ['1','01','001','0001']
            }
        }

    def process(self, node_action, original_file, transform_text, state):
        base, name, ext = self.get_file_info(transform_text)

        if state is None:
            # try to initialize with text if present
            try:
                state = int(node_action['text'])
            except:
                state = 0
        at_start = node_action['choices']['at'] == 'begin'
        format = node_action['choices']['f']
        format_string = self.formats[format]
        number = (format_string % state).replace(' ','0')
        if at_start:
            name = number + name
        else:
            name = name + number
        state = state + 1
        return self.get_transformed_filename(base,name,ext), state

    def get_summary(self, node_action, sample_text=None):
        try:
            state = int(node_action['text'])
        except:
            state = 0
        state = str(state)
        at_start = node_action['choices']['at'] == 'begin'
        if at_start:
            return "add number from " + state + ", at beginning"
        else:
            return "add number from " + state + ", at end"

