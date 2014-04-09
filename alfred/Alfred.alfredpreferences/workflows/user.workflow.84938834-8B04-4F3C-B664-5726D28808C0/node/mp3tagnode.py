from core import Node
import eyed3

class Mp3TagNode(Node):

    valid_tags = ['#artist','#album','#title','#track']

    def __init__(self):
        super(Mp3TagNode,self).__init__('node_mp3', "MP3 tagger (beta)", 'Add a specified MP3 tag to the filename', 'icons/mp3.png')

    def get_choices(self):
        return {
            # Where should the tag be added
            'at': {
                'display': 'add at: ',
                'values': ['end', 'start']
            }
        }

    def process(self, node_action, original_file, transform_text, state):
        format_text = node_action['text']

        if format_text is None or len(format_text) == 0:
            return transform_text, state

        at_start = node_action['choices']['at'] == 'start'
        base, name, ext = self.get_file_info(transform_text)
        format_text = self.format(format_text, original_file)
        if at_start:
            name = format_text + name
        else:
            name = name + format_text

        return self.get_transformed_filename(base,name,ext), state

    def format(self, format_text, original_file):
        # check if have any valid tags to process
        found_tags = False
        for t in self.valid_tags:
            if format_text.find(t) >= 0:
                found_tags = True
                break
        if not found_tags:
            return format_text
        # process each tag
        try:
            audiofile = eyed3.load(original_file)
            for t in self.valid_tags:
                if format_text.find(t) >= 0:
                    format_text = format_text.replace(t, self.get_tag(t, audiofile.tag))
            return format_text
        except Exception, e:
            for t in self.valid_tags:
                if format_text.find(t) >= 0:
                    format_text = format_text.replace(t,t+'_error')
            return format_text

    def get_tag(self, tag_text, tag):
        switch = {
            '#artist': lambda x: x.artist,
            '#album': lambda x: x.album,
            '#title': lambda x: x.title,
            '#track': lambda x: str(x.track_num[1]),
        }
        value = switch[tag_text](tag)
        if value is None:
            return tag_text+'_error'
        return value


    def get_summary(self, node_action, sample_text=None):
        tag = node_action['text']
        if len(tag) == 0:
            return "Valid tags are " + ", ".join(self.valid_tags)
        at_start = node_action['choices']['at'] == 'start'
        if at_start:
            return "add " + tag + " at start"
        else:
            return "add " + tag + " at end"
