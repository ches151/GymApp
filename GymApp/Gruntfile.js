var grunt = require('grunt');
grunt.loadNpmTasks('grunt-real-favicon');

grunt.initConfig({
    realFavicon: {
        favicons: {
            src: 'Content/icons/favicon/ic_fitness_center_black_48px.svg',
            dest: 'Content/icons/favicon',
            options: {
                iconsPath: '/Content/icons/favicon',
                html: ['Views/Default/Index.cshtml'],
                design: {
                    ios: {
                        pictureAspect: 'backgroundAndMargin',
                        backgroundColor: '#ffffff',
                        margin: '11%'
                    },
                    desktopBrowser: {},
                    windows: {
                        pictureAspect: 'whiteSilhouette',
                        backgroundColor: '#26a69a',
                        onConflict: 'override'
                    },
                    androidChrome: {
                        pictureAspect: 'shadow',
                        themeColor: '#ffffff',
                        manifest: {
                            name: 'Gym App',
                            startUrl: 'http://gymapp.azurewebsites.net/',
                            display: 'standalone',
                            orientation: 'portrait',
                            onConflict: 'override',
                            declared: true
                        }
                    },
                    safariPinnedTab: {
                        pictureAspect: 'silhouette',
                        themeColor: '#5bbad5'
                    }
                },
                settings: {
                    scalingAlgorithm: 'Mitchell',
                    errorOnImageTooSmall: false
                },
                versioning: {
                    paramName: 'v',
                    paramValue: 'eEEro2gwd9'
                }
            }
        }
    }
});