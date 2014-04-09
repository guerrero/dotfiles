from core import Node
import re

class FindReplaceNode(Node):

    def __init__(self):
        super(FindReplaceNode,self).__init__('node_findreplace', "Find and replace", 'Find a string/pattern and replace with text', 'icons/findreplace.png')

    def get_choices(self):
        return {
            'ic': {
                'display': 'ignore case: ',
                'values': ['yes','no']
            },
            're':{
                'display': 'is regex: ',
                'values': ['no','yes']
            }
        }

    def process(self, node_action, original_file, transform_text, state):
        base, name, ext = self.get_file_info(transform_text)

        split_up = node_action['text'].split('->')
        if len(split_up) == 2:
            find_text = split_up[0]
            replace_text = split_up[1]

            is_regex = node_action['choices']['re'] == 'yes'
            is_ignorecase = node_action['choices']['ic'] == 'yes'

            try:
                if is_ignorecase and not is_regex:
                    ci_search = re.compile(re.escape(find_text), re.IGNORECASE)
                    name = ci_search.sub(replace_text, name)
                elif is_ignorecase and is_regex:
                    ci_search = re.compile(find_text, re.IGNORECASE)
                    name = ci_search.sub(replace_text, name)
                elif is_regex and not is_ignorecase:
                    search = re.compile(find_text)
                    name = search.sub(replace_text, name)
                elif not is_regex and not is_ignorecase:
                    name = name.replace(find_text, replace_text)
            except:
                return transform_text, state

        return self.get_transformed_filename(base,name,ext), state

    def get_summary(self, node_action, sample_text=None):
        split_up = node_action['text'].split('->')
        if len(split_up) != 2:
            return "Enter as find_text->replace_text"

        is_regex = node_action['choices']['re'] == 'yes'
        is_ignorecase = node_action['choices']['ic'] == 'yes'

        if is_regex:
            try:
                r = re.compile(split_up[0])
            except Exception,e:
                return "error: "+ str(e)

        return "replace " + ("regex " if is_regex else '') +  "'" + split_up[0] + "' with '" + split_up[1] + "'" + (", case-sensitive" if not is_ignorecase else '')


