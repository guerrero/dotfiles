import node

node_cache = {
    'node_text': node.TextNode(),
    'node_number': node.NumberNode(),
    'node_convertcase': node.ConvertCaseNode(),
    'node_findreplace': node.FindReplaceNode(),
    'node_striptext': node.StripTextNode(),
    'node_date': node.DateNode(),
    'node_regex': node.RegexPatternNode(),
    'node_mp3': node.Mp3TagNode()
}


def get_target(target):
    return node_cache[target]
