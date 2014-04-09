import node
from pprint import pprint
import node_cache
import preset_manager


def main():

    original = ['/Users/benzi/Desktop/rome2rio.taskpaper']
    preset = []

    # add numbering scheme
    date_node = node_cache.get_target('node_date')
    preset.append(date_node.get_preset_node('n:YYYY_MM_DD_hh_mm_ss @t(current)'))
    preset.append(date_node.get_preset_node('c:YYYY_MM_DD_hh_mm_ss @t(created)'))
    preset.append(date_node.get_preset_node('o:YYYY_MM_DD_hh_mm_ss @t(modified)'))

    pprint(preset)

    modified = preset_manager.run_preset(preset, original)

    pprint(modified)

if __name__ == '__main__':
    main()