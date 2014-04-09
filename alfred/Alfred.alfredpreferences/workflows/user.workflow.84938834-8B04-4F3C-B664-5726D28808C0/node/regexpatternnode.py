from core import Node
import re


class RegexPatternNode(Node):

    def __init__(self):
        super(RegexPatternNode, self).__init__('node_regex', "Extract regex group", 'Powerful regex group based search and replace', 'icons/regex.png')

    def get_choices(self):
        return {
        }

    def process(self, node_action, original_file, transform_text, state):
        user_command = node_action['text']
        if user_command.find("//") < 0:
            # no action to be performed unless we find
            # the replace operator
            return transform_text, state

        (u_pattern, u_replace) = user_command.split("//",2)
        try:
            p = re.compile(u_pattern)
        except:
            # in case we are not able to use the
            # pattern, just return
            return transform_text, state

        base, name, ext = self.get_file_info(transform_text)

        m = p.search(name)
        if not m:
            # if we do not have any matches
            # just return
            return transform_text, state

        # create a dictionary so that $1=>group(0)
        mapping = {}
        for i, g in enumerate(m.groups()):
            mapping[ '$'+str(i+1) ] = g
        mapping_info = ",".join([k+'='+v for k,v in mapping.iteritems()])

        # now find out all the replace groups
        # defined
        replace_groups = list(set(re.findall("(\$\d+)", u_replace)))
        # is a list with '$1', '$2', ...
        for replace_group in replace_groups:
            replace_text = mapping.get(replace_group,'')
            u_replace = u_replace.replace(replace_group, replace_text)

        name = u_replace

        return self.get_transformed_filename(base, name, ext), state

    def get_summary(self, node_action, sample_text=None):
        user_command = node_action['text']
        # format is pattern//replace with groups
        if len(user_command) == 0:
            return "Enter command as pattern//replace"
        if user_command.find("//") < 0:
            return "Groups referred as $1,$2... in replace term"
        if user_command.find("//") >= 0:
            (u_pattern, u_replace) = user_command.split("//",2)
            try:
                p = re.compile(u_pattern)
                # user has not entered any replace term
                # so describe what the user has entered
                # for the pattern
                num_groups = p.groups
                pattern = p.pattern

                if sample_text is None:
                    return "'%s' with '%s'" % (pattern, u_replace)

                if num_groups == 0:
                    return "'%s' with '%s', no groups defined" % (pattern, u_replace)

                # create a dictionary so that $1=>group(0)
                base, sample_text, ext = self.get_file_info(sample_text)
                mapping = {}
                m = p.search(sample_text)
                if m:
                    for i, g in enumerate(m.groups()):
                        mapping[ '$'+str(i+1) ] = g
                    mapping_info = ", ".join(sorted([k+'='+v for k,v in mapping.iteritems()]))
                    return mapping_info
                else:
                    return "'%s' with '%s', groups:%d" % (pattern, u_replace, num_groups)


            except Exception, e:
                return "error: " + str(e)

