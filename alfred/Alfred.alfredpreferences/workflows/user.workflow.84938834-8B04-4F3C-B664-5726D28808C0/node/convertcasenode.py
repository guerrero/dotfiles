from core import Node
from titlecase import titlecase

class ConvertCaseNode(Node):

    def __init__(self):
        super(ConvertCaseNode,self).__init__('node_convertcase', "Convert case", "Change to title, lower and upper case", 'icons/convertcase.png')

    def get_choices(self):
        return {
            # What case is to be supported
            'case': {
                'display': 'switch case to: ',
                'values': ['lower', 'upper', 'title']
            },
        }

    def process(self, node_action, original_file, transform_text, state):
        base, name, ext = self.get_file_info(transform_text)

        action = {
            'lower': lambda x: x.lower(),
            'upper': lambda x: x.upper(),
            'title': lambda x: titlecase(x),
        }
        name = action[node_action['choices']['case']](name)

        return self.get_transformed_filename(base,name,ext), state

    def get_summary(self, node_action, sample_text=None):
        return 'change to ' + node_action['choices']['case'] + ' case'