import alfred
import os
import config


def view(query):
    feedback = []
    # list out all files
    # look in two folders
    # samples and non volatile -> preset
    user_presets_folder = alfred._create( os.path.join(alfred.work(False), 'user_presets') )
    user_presets = [f for f in os.listdir(user_presets_folder) if f.endswith('.json') and (query is None or f.lower().find(query.lower())>=0)]
    for preset in user_presets:
        preset_path = os.path.join(user_presets_folder, preset)
        feedback.append(alfred.item(
            title=preset.replace(".json",""),
            arg=preset_path,
            valid='yes',
            uid=alfred.uid(preset_path),
            icon='icons/preset.png'
        ))

    sample_presets = [f for f in os.listdir('./samples') if f.endswith('.json') and  (query is None or f.lower().find(query.lower())>=0)]
    for sample in sample_presets:
        preset_path = os.path.join('./samples', sample)
        feedback.append(alfred.item(
            title=sample.replace(".json",""),
            subtitle="sample",
            arg=preset_path,
            valid='yes',
            uid=alfred.uid(preset_path),
            icon='icons/preset.png'
        ))

    if len(sample_presets) == 0 and len(user_presets) == 0:
        feedback.append(alfred.item(
            title="Add new preset: " + query + ".json",
            arg=os.path.join(user_presets_folder, query+'.json'),
            valid='yes'
        ))

    alfred.write(alfred.xml(feedback))

def edit(preset):
    config.put(config.KEY_PRESET_VIEWING, preset)
    alfred.show('.preset ')

def delete(preset):
    if os.path.exists(preset):
        os.remove(preset)
    alfred.show('.list ')

def main():
    command, data = alfred.args2()
    switch = {
    '--view': lambda x: view(x),
    '--edit': lambda x: edit(x),
    '--delete': lambda x: delete(x)
    }
    switch[command](data)

if __name__ == '__main__':
    main()

