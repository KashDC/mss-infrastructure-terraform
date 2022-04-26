

'use strict';

module.exports = function (grunt) {
    return {
        dist: {
            files: [
                {
                    dest: '<%= pkg.config.dist %>/',
                    src: 'LICENSE'
                },
                {
                    cwd: '<%= pkg.config.src %>',
                    expand: true,
                    flatten: true,
                    filter: 'isFile',
                    dest: '<%= pkg.config.dist %>/',
                    src: 'css/**',
                }
            ]
        }
    };
};
