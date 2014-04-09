from core import Node
import datetime
import os

class DateNode(Node):

    def __init__(self):
        super(DateNode,self).__init__('node_date', "Add timestamp", 'Add current time, file created or modified', 'icons/datetime.png')

    def get_choices(self):
        return {
            # Where should the text be changed
            'at': {
                'display': 'add at: ',
                'values': ['end', 'start']
            },
            't': {
                'display': 'timestamp from: ',
                'values': ['current','created','modified']
            }
        }

    def process(self, node_action, original_file, transform_text, state):
        base, name, ext = self.get_file_info(transform_text)

        # default
        timestamp = datetime.datetime.now()
        if node_action['choices']['t'] == 'created':
            if os.path.exists(original_file):
                timestamp = self.creation_timestamp(original_file)
        elif node_action['choices']['t'] == 'modified':
            if os.path.exists(original_file):
                timestamp = self.modification_timestamp(original_file)

        # print "---------"
        # print "file: " + original_file
        # print "current: " + str(datetime.datetime.now())
        # print "created: " + str(self.creation_timestamp(original_file))
        # print "modified: " + str(self.modification_timestamp(original_file))
        # print "---------"

        user_format = node_action['text']

        user_format = self.format(user_format, timestamp)
        at_start = node_action['choices']['at'] == 'start'

        if at_start:
            name = user_format + name
        else:
            name = name + user_format

        return self.get_transformed_filename(base,name,ext), state

    def format(self, format, timestamp):
        # replace format with value
        # YYYY - year
        # YY - year, last two digits
        # MM - month, leading zero
        # M - month
        # DD - day, leading zero
        # D - day
        # hh - hour, leading zero
        # h - hour
        # mm - minute, leading zero
        # m - minute
        # ss - second, leading zero
        # s - second
        format = format.replace("YYYY", str(timestamp.year))
        format = format.replace("YY", str(timestamp.year)[2:])
        format = self.format_code(format,"MM",timestamp.month,leading=True)
        format = self.format_code(format,"M",timestamp.month,leading=False)
        format = self.format_code(format,"DD",timestamp.day,leading=True)
        format = self.format_code(format,"D",timestamp.day, leading=False)
        format = self.format_code(format,"hh",timestamp.hour,leading=True)
        format = self.format_code(format,"h",timestamp.hour, leading=False)
        format = self.format_code(format,"mm",timestamp.minute,leading=True)
        format = self.format_code(format,"m",timestamp.minute, leading=False)
        format = self.format_code(format,"ss",timestamp.second,leading=True)
        format = self.format_code(format,"s",timestamp.second, leading=False)
        return format

    def format_code(self, format, code, value, leading=False):
        value = str(value)
        if leading and len(value)!=2:
            value = '0' + value
        return format.replace(code, value)

    def modification_timestamp(self, filename):
        t = os.path.getmtime(filename)
        return datetime.datetime.fromtimestamp(t)

    def creation_timestamp(self, filename):
        t = os.path.getctime(filename)
        return datetime.datetime.fromtimestamp(t)

    def get_summary(self, node_action, sample_text=None):
        timestamp = datetime.datetime.now()
        user_format = node_action['text']

        # user_format = self.format(user_format, timestamp)
        at_start = node_action['choices']['at'] == 'start'
        fromtimestamp = node_action['choices']['t']

        if at_start:
            return "{0} {1}, start".format(fromtimestamp, user_format, self.format(user_format, timestamp))
        else:
            return "{0} {1}, end".format(fromtimestamp, user_format, self.format(user_format, timestamp))

