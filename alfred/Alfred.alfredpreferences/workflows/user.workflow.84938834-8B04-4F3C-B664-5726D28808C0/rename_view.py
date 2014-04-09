import alfred
import json
import os
import preset_manager
from string import Template
import codecs
import shutil
import subprocess


def get_path():
    return os.path.join(alfred.work(False), 'files.json')


def save_files(data, show=True):
    files = data.split('\t')
    files = [f for f in files if os.path.exists(f) and os.path.isfile(f)]
    with open(get_path(), 'w') as f:
        json.dump(files, f)
    if show:
        alfred.show('.rename ')


def get_files():
    if not os.path.exists(get_path()):
        return get_finder_selection()
    with open(get_path(), 'r') as f:
        files = json.load(f)
    if len(files) == 0:
        return get_finder_selection()
    return files

def get_finder_selection():
    p = subprocess.Popen(['osascript', 'get_finder_selection.scpt'], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    (stdoutdata, stderrdata) = p.communicate()
    files = stdoutdata.split('\t')
    files = [f.strip() for f in files]
    files = [f for f in files if os.path.exists(f) and os.path.isfile(f)]
    if files is None:
        return []
    return files


def generate_full_preview():
    header = Template('''
        <h3>$header</h3>
        <p class='lead'>
            <ul>
                $steps
            </ul>
        <p>
    ''')
    table_top = '''
        <br>
        <table class='table table-bordered table-condensed table-striped'>
            <thead>
                <tr>
                    <th>Before</th>
                    <th>After</th>
                </tr>
            </thead>
            <tbody>
    '''
    table_row = Template(u'''
                <tr>
                    <td>$old</td>
                    <td>$new $extrainfo</td>
                </tr>
    ''')
    table_bottom = '''
            </tbody>
        </table>
    '''
    files = get_files()
    files = [f for f in files if os.path.exists(f)]
    preview_contents = []
    preview_contents.append('''
    <html>
        <head>
        <title>BulkRename preview</title>
        <link href='bulkrename_alfred_preview_bootstrap.css' rel='stylesheet'/>
        <style type='text/css'>
            body{margin: 20px 100px;}
            h3{margin-top:50px;}
        </style>
        </head>
        <body>

    ''')
    for p in preset_manager.get_all_presets():
        preset = preset_manager.load_preset(p)

        # header
        steps = preset_manager.get_preset_steps(preset)
        steps = ['<li>' + s + '</li>' for s in steps]
        preview_contents.append(header.substitute({
            'header': os.path.splitext(os.path.basename(p))[0],
            'steps': ''.join(steps)
        }))

        # table
        preview_contents.append(table_top)
        # run the preset
        preset_output = preset_manager.run_preset(preset, files)
        for item in zip(files, preset_output):
            (old, new) = item

            rowclass = ''
            extrainfo = ''
            if os.path.exists(new) and os.path.exists(old) and old == new:
                extrainfo = '<span class="label label-warning">no change</span>'

            elif os.path.exists(new) and os.path.exists(old) and old.lower() == new.lower():
                extrainfo = '<span class="label label-info">title change</span>'

            elif os.path.exists(new) and old != new:
                extrainfo = '<span class="label label-important">file exists</span>'

            else:
                duplicates = [d for d in preset_output if d == new]
                if len(duplicates) > 1:
                    extrainfo = '<span class="label label-important">duplicate</span>'

            old = os.path.basename(old)
            new = os.path.basename(new)
            preview_contents.append(table_row.substitute(
                # http://stackoverflow.com/questions/1061697/whats-the-easiest-way-to-escape-html-in-python
                {'old': old.encode('ascii', 'xmlcharrefreplace'),
                 'new': new.encode('ascii', 'xmlcharrefreplace'),
                 'extrainfo': extrainfo
                 }
            ))
        # footer
        preview_contents.append(table_bottom)
        preview_contents.append("<p>")
        preview_contents.append("</p>")

    preview_contents.append("""</body></html>""")
    preview_path = os.path.join("/tmp", 'bulkrename_alfred_preview.html')
    with codecs.open(preview_path, "w", "utf-8") as f:
        for i in preview_contents:
            print>>f, i

    if not os.path.exists('/tmp/bulkrename_alfred_preview_bootstrap.css'):
        shutil.copyfile('./bootstrap.css', '/tmp/bulkrename_alfred_preview_bootstrap.css')

    return preview_path


def view(query):
    feedback = []
    files = get_files()

    # make sure we have valid existing files
    files = [f for f in files if os.path.exists(f) and os.path.isfile(f)]

    if len(files) == 0:
        feedback.append(alfred.item(title="Select files in Finder, or from Alfred"))
    else:
        # preview item
        first_file = os.path.basename(files[0])
        all_files = files
        and_more = ''
        if len(all_files) > 3:
            and_more = ' and {0} more files'.format(len(all_files)-3)
            all_files = all_files[:3]
        all_files_names = [os.path.basename(f) for f in all_files]
        subtitle = ', '.join(all_files_names) + and_more

        # only one selection, then show a manual
        # file name change
        if len(all_files) == 1 and len(query) > 0:
            feedback.append(alfred.item(
                title="Change to '" + query + os.path.splitext(files[0])[1] + "'",
                subtitle="Valid: " + ('yes' if is_valid(get_new_file_name(files[0], query)) else 'no'),
                arg=query,
                valid='yes' if is_valid(get_new_file_name(files[0], query)) else 'no',
                autocomplete=query
            ))

        preview_path = generate_full_preview()

        feedback.append(alfred.item(
            title="Shift to preview",
            subtitle=subtitle,
            arg="file://" + preview_path,
            autocomplete=query
        ))

        # display all preset items
        # with a preview of the first file
        presets = preset_manager.get_all_presets()
        for p in presets:
            preset = preset_manager.load_preset(p)
            preset_name = os.path.splitext(os.path.basename(p))[0]
            preset_input = []
            preset_input.append(files[0])
            preset_output = preset_manager.run_preset(preset, preset_input)
            preset_output = os.path.basename(preset_output[0])
            feedback.append(alfred.item(
                title=preset_name,
                subtitle=preset_output,
                arg=p,
                valid='yes',
                icon='icons/preset.png'
            ))

    alfred.write(alfred.xml(feedback))


def is_valid(file_path):
    return not os.path.exists(file_path)


def get_new_file_name(old_file_path, new_name):
    base, name = os.path.split(old_file_path)
    name, ext = os.path.splitext(name)
    return os.path.join(base, new_name+ext)


def rename_selection(p):
    if os.path.exists(p) and os.path.isfile(p):
        run_preset(p)
        return

    # manual file change, we can change only
    # one at a time
    file_paths = get_files()
    if len(file_paths) != 1:
        return

    old_file_name = file_paths[0]
    new_file_name = get_new_file_name(old_file_name, p)
    os.rename(old_file_name, new_file_name)
    save_files('', show=False)


def run_preset(p):
    preset = preset_manager.load_preset(p)
    file_paths = get_files()
    errors = []
    # files is not full path to file
    # we will extract the file name one by one and then rename it
    input_files = file_paths
    output_files = preset_manager.run_preset(preset, input_files)

    for item in zip(input_files, output_files):
        (in_file, out_file) = item
        try:
            if in_file == out_file:
                continue
            if in_file.lower() == out_file.lower() and in_file != out_file:
                # case changes
                os.rename(in_file, out_file)
            elif not os.path.exists(out_file):
                os.rename(in_file, out_file)
        except:
            errors.append(out_file)
    save_files('', show=False)


def main():
    command, data = alfred.args2()
    switch = {
        '--files': lambda x: save_files(data),
        '--view': lambda x: view(x),
        '--run': lambda x: rename_selection(x)
    }
    switch[command](data)

if __name__ == '__main__':
    main()
