import re
from uuid import uuid4
import os

class Node(object):

    display_name = 'Node'

    def __init__(self, type_name, display_name, help_text, icon):
        self.type_name = type_name
        self.display_name = display_name
        self.help_text = help_text
        self.icon = icon

    def get_id(self):
        pass

    def get_choices(self):
        pass

    def process(self, node_action, transform_text, state):
        pass

    def get_summary(self, preset_node):
        pass

    def get_default_choice(self, code):
        # { 'code': { 'display':'', 'values':[''] } }
        choices = self.get_choices()
        for choice_code, choice_definition in choices.iteritems():
            if code == choice_code:
                return choice_definition['values'][0]
        raise Exception('invalid code: ' + code)

    def get_next_choice(self, code, current):
        choices = self.get_choices()
        for choice_code, choice_definition in choices.iteritems():
            if choice_code == code:
                total_choices = len(choice_definition['values'])
                if total_choices == 1:
                    return current
                try:
                    current_index = choice_definition['values'].index(current)
                    current_index += 1
                    if current_index == total_choices:
                        current_index = 0
                    return choice_definition['values'][current_index]
                except ValueError:
                    # we can't find the current choice
                    # so return the default
                    return choice_definition['values'][0]
        raise Exception('invalid code: ' + code)

    # returns choice if its valid, else
    # the default choice
    def validate_choice(self, code, choice):
        choices = self.get_choices()
        for choice_code, choice_definition in choices.iteritems():
            if choice_code == code:
                total_choices = len(choice_definition['values'])
                try:
                    current_index = choice_definition['values'].index(choice)
                    return choice
                except ValueError:
                    # we can't find the current choice
                    # so return the default
                    return choice_definition['values'][0]
        raise Exception('invalid code: ' + code)

    # UI
    def get_autocomplete_for_choice(self, code, query_text):
        # if there is only one item for the code
        # no need to loopover
        if len(self.get_choices()[code]['values']) == 1:
            return query_text

        # find if we already have a choice specified in the query text
        m = re.match(r'.*? [@]'+re.escape(code)+'\((?P<current_choice>.*?)\).*', query_text)
        if m:
            current_choice = self.validate_choice(code, m.group('current_choice'))
            next_choice = self.get_next_choice(code, current_choice)
            query_text = query_text.replace(self.get_choice_tag(code, current_choice), self.get_choice_tag(code, next_choice))
        else:
            # if there is no choice, just add the default
            query_text = query_text + self.get_choice_tag(code, self.get_next_choice(code, self.get_default_choice(code)))
        return query_text

    # UI
    def get_active_choice(self, code, query_text):
        # find if we already have a choice specified in the query text
        m = re.match(r'.*? [@]'+re.escape(code)+'\((?P<current_choice>.*?)\).*', query_text)
        if m:
            current_choice = m.group('current_choice')
            return self.validate_choice(code, current_choice)
        else:
            # if there is no choice, just add the default
            return self.get_default_choice(code)

    def get_choice_tag(self, code, choice):
        return ' @' + code + '(' + choice + ')'

    def get_preset_node(self, query_text):
        preset_node = {}
        preset_node['type'] = self.type_name
        preset_node['id'] = str(uuid4())
        node_action = {}
        # get just the text entered by the user
        # devoid of all tags
        clean_tag_query = query_text
        node_action['choices'] = {}
        for code, definition in self.get_choices().iteritems():
            m = re.match(r'.*? [@]'+re.escape(code)+'\((?P<current_choice>.*?)\).*', query_text)
            if m:
                current_choice = m.group('current_choice')
                node_action['choices'][code] = current_choice
                tag = self.get_choice_tag(code, current_choice)
                clean_tag_query = clean_tag_query.replace(tag, '')
            else:
                # add the default, so always this will have the full
                # list of choices
                node_action['choices'][code] = self.get_default_choice(code)
        node_action['text'] = clean_tag_query
        preset_node['node_action'] = node_action
        return preset_node

    def get_query(self, preset_node):
        query = preset_node['text']

        # for each choice add text only if the preset node's
        # choice is not the default
        for code, selection in preset_node['choices'].iteritems():
            default = self.get_default_choice(code)
            if selection != default:
                query = query + self.get_choice_tag(code, selection)

        return query

    def get_file_info(self, filename):
        # returns base, name, extension
        base, name = os.path.split(filename)
        name, ext = os.path.splitext(name)
        # in case ext is empty
        if ext == '':
            ext = name
            name = ''
        return base, name, ext

    def get_transformed_filename(self, base, name, ext):
        return os.path.join(base, name+ext)


