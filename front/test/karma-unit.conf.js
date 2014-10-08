// Karma configuration
// Generated on Wed May 21 2014 13:09:02 GMT+0200 (CEST)

module.exports = function(config) {
  config.set({

    // base path, that will be used to resolve files and exclude
    basePath: '',


    // frameworks to use
    frameworks: ['jasmine'],

    preprocessors: {
      '../**/*.coffee': ['coffee']
    },


    // list of files / patterns to load in the browser
    files: [
      '../lib/angular/angular.js',
      '../lib/angular-route/angular-route.js',
      '../lib/angular-mocks/angular-mocks.js',
      '../lib/angular-cookies/angular-cookies.js',
      '../lib/angular-bootstrap/ui-bootstrap.js',
      '../lib/angular-ui/build/angular-ui.js',
      '../lib/angular-ui-utils/ui-utils.js',
      '../lib/angular-ui-utils/ui-utils-ieshiv.js',
      '../lib/angular-ui-router/release/angular-ui-router.js',
      '../lib/moment/moment.js',
      '../../tmp/front/scripts/Config.js',
      '../app/scripts/**/*.coffee',
      './unit/**/*Spec.coffee'
    ],


    // list of files to exclude
    exclude: [

    ],


    // test results reporter to use
    // possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
    reporters: ['progress'],


    // web server port
    port: 9876,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: false,


    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers: ['ChromeCanary'],


    // If browser does not capture in given timeout [ms], kill it
    captureTimeout: 60000,


    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: false
  });
};
