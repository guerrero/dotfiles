/*
* grunt-init-jquery
* https://gruntjs.com/
*
* Copyright (c) 2013 "Cowboy" Ben Alman, contributors
* Licensed under the MIT license.
*/

// 'use strict';

// Basic template description
exports.description = 'Create a template for small proyects with Bower, Sass and Autoprefixer';

// Template-specific notes to be displayed before question prompts.
exports.notes = 'VAMOOOS!';

// Template-specific notes to be displayed after question prompts.
exports.after = 'You should now install project dependencies with _npm ' +
'install_. After that, you may execute project tasks with _grunt_. For ' +
'more information about installing and configuring Grunt, please see ' +
'the Getting Started guide:' +
'\n\n' +
'http://gruntjs.com/getting-started';

// Any existing file or directory matching this wildcard will cause a warning.
exports.warnOn = '*';

// The actual init template.
exports.template = function(grunt, init, done) {

  init.process({}, [
    // Prompt for these values.
    init.prompt('name'),
    init.prompt('description', 'Awesome!'),
    init.prompt('version'),
    init.prompt('author_name', init.defaults.author_name)
  // All finished, do something with the properties
  ], function(err, props) {
    props.keywords = [];
    props.devDependencies = {
      'grunt': '~0.4.0',
      'grunt-contrib-copy': '~0.4.0',
      'grunt-contrib-concat': '~0.3.0',
      'grunt-contrib-uglify': '~0.2.0',
      'grunt-contrib-jshint': '~0.4.0',
      'grunt-contrib-watch': '~0.4.0',
      "grunt-contrib-sass": "~0.4.0",
      "grunt-contrib-clean": "~0.5.0",
      "grunt-autoprefixer": "~0.5.0",
      "grunt-contrib-imagemin": "~0.3.0",
      "grunt-contrib-connect": "~0.5.0",
      "grunt-contrib-compress": "~0.3.0",
      "grunt-contrib-htmlmin": "~0.1.3"
    };

    // Files to copy (and process)
    // absolute source path and relative destination path
    // Renamed or ommited according to rules in rename.json (if it exists)
    var files = init.filesToCopy(props);

    // Add properly-named license files if license is defined.
    if (props.hasOwnProperty('license')) {
      init.addLicenseFiles(files, props.licenses);
    }

    // Actually copy (and process) files.
    init.copyAndProcess(files, props);

    // Generate package.json file.
    init.writePackageJSON('package.json', props);

    // TODO:
    // Probar 'none' en prompt
    // Probar a ver si puedo hacer los renames directamente aqui

    // All done!
    done();
  });

};

