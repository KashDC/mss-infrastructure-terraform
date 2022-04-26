

'use strict';

module.exports = function (grunt) {
    return {
        options: {
            jshintrc: '.jshintrc',
            reporter: require('jshint-stylish')
        },
        all: [
            'Gruntfile.js',
            '<%= pkg.config.src %>/{,*/}*.js',
            '<%= pkg.config.site %>/scripts/{,*/}*.js'
        ],
        test: {
            options: {
                jshintrc: '<%= pkg.config.test %>/.jshintrc'
            },
            src: ['<%= pkg.config.test %>/spec/{,*/}*.js']
        }
    };
};
