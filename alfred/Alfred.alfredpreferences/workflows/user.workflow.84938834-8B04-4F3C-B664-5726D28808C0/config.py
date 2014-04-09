import alfred
import json
import codecs
import os
import sys

KEY_PRESET_VIEWING = 'renameit.preset.viewing'
KEY_NODE_ACTION = 'renameit.node.action'

def get_path():
    return os.path.join(alfred.work(False), 'config.json')


def load_config():
    config_file = get_path()
    if not os.path.exists(config_file):
        with codecs.open(config_file, "w", "utf-8") as f:
            json.dump({}, f, ensure_ascii=False, indent=1)
    with open(config_file, 'r') as f:
        config = json.load(f)
    return config


def save_config(config):
    with codecs.open(get_path(), "w", "utf-8") as f:
        json.dump(config, f, ensure_ascii=False, indent=1)


def get(key):
    config = load_config()
    if key in config:
        return config[key]
    return None


def put(key, value):
    config = load_config()
    config[key] = value
    save_config(config)

def print_config():
    print get_path()
    print load_config()

def print_key(key):
    print get(key)

def cli_put():
    put(sys.argv[2], sys.argv[3])

def reset():
    save_config({})

def main():
    command, data = alfred.args2()
    command_switch= {
    '--load': lambda x: print_config(),
    '--get': lambda x: print_key(x),
    '--put': lambda x: cli_put(),
    '--reset': lambda x: reset()
    }
    command_switch[command](data)


if __name__ == '__main__':
    main()
