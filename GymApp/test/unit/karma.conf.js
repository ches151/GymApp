/* global module */
module.exports = function (config) {
    config.set({

        // base path that will be used to resolve all patterns (eg. files, exclude)
        basePath: '..',

        // frameworks to use
        // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
        frameworks: ['jasmine'],

        files: [
          'bower_components/angular/angular.js',
          'bower_components/angular-route/angular-route.js',
          'bower_components/angular-animate/angular-animate.js',
          'bower_components/angular-resource/angular-resource.js',
          'bower_components/angular-aria/angular-aria.js',
          'bower_components/angular-messages/angular-messages.js',
          'bower_components/angular-material/angular-material.js',
          'bower_components/angular-bootstrap/ui-bootstrap-tpls.js',
          'app/js/**/*.js'
        ],

        autoWatch: true,

        browsers: ['Chrome'],

        plugins: [
                'karma-chrome-launcher',
                'karma-firefox-launcher',
                'karma-jasmine',
                'karma-junit-reporter'
        ],

        junitReporter: {
            outputFile: 'test_out/unit.xml',
            suite: 'unit'
        }

    });
};