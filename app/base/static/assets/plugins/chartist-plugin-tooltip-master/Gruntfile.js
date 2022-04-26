

'use strict';

module.exports = function (grunt) {

    // tracks how long a tasks take
    require('time-grunt')(grunt);

    // load task and configurations
    require('load-grunt-config')(grunt, {
        configPath: __dirname + '/tasks',
        data: {
            pkg: grunt.file.readJSON('package.json'),
            year: new Date().getFullYear()
        }
    });
};
