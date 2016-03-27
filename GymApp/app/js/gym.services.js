(function () {
    'use strict';
    var app = angular.module('gym.services', ['tools']);
    app.factory('domFactory', ['$window', '$document', '$timeout', '$location', '$anchorScroll', '$log', 'tools',
        function ($window, $document, $timeout, $location, $anchorScroll, $log, tools) {
            $log.log('gym.services.domFactory singleton');

            return {
                setFocus: function (id) {
                    // timeout makes sure that it is invoked after any other event has been triggered.
                    // e.g. click events that need to run before the focus or
                    // inputs elements that are in a disabled state but are enabled when those events
                    // are triggered.
                    $timeout(function () {
                        var element = $window.document.getElementById(id);
                        if (element)
                            element.focus();
                    });
                },
                launchFullscreen: function () {
                    tools.enterFullscreen($document[0].documentElement);
                },
                exitFullscreen: function () {
                    tools.exitFullscreen();
                },
                scrollElementIntoView: function (id) {
                    $location.hash(id);
                    $anchorScroll();
                }
            };
        }]);
    app.factory('header', ['$window', '$location', '$log', 'domFactory'
    , function ($window, $location, $log, domFactory) {
        $log.log('gym.services.header singleton');
        var self = this;
        self.fullscreen = false;

        function goBack() {
            $window.history.back();
        }

        function go(url) {
            $location.path(url);
        }

        function toggleFullScreen() {
            if ((self.fullscreen = !self.fullscreen)) {
                domFactory.launchFullscreen();
            }
            else {
                domFactory.exitFullscreen();
            }
            return self.fullscreen;
        }

        return {
            title: 'Gym App',
            toggleFullScreen: toggleFullScreen,
            canGoBack: false,
            goBack: goBack,
            go: go
        };
    }]);
    app.factory('massUnits', ['$log', function ($log) {
        $log.log('gym.services.massUnits singleton');

        return [
            {
                name: 'kg',
                factor: 1
            },
            {
                name: 'lb',
                factor: 0.453592
            }];
    }]);

    app.factory('workoutsService', ['$http', '$log', 'settings',
    function workoutsService($http, $log, settings) {
        $log.log('gym.services.workoutsService singleton');

        var rootUrl = settings.rootUrl || '/';

        function getFullUrl(url) {
            return rootUrl.length > 1
                ? rootUrl + '/' + url
                : rootUrl + url;
        }

        function getWorkouts() {
            return $http.get(getFullUrl('odata/Workouts?$expand=exercises'));
        }
        function getExercises() {
            return $http.get(getFullUrl('odata/Exercises'));
        }

        function deleteWorkoutById(workoutId) {
            return $http.delete(getFullUrl('odata/Workouts(' + workoutId + ')'));
        }

        function getWorkoutById(workoutId) {
            return $http.get(getFullUrl('odata/Workouts(' + workoutId + ')?$expand=exercises'));
        }

        function addWorkout(newWorkout) {
            return $http.post(getFullUrl('odata/Workouts?$expand=exercises'), newWorkout);
        }

        return {
            getWorkouts: getWorkouts,
            getExercises: getExercises,
            addWorkout: addWorkout,
            getWorkoutById: getWorkoutById,
            deleteWorkoutById: deleteWorkoutById
        };
    }]);

    app.factory('exerciseSetsService', ['$resource', '$log', 'settings',
    function exerciseSetsService($resource, $log, settings) {
        $log.log('gym.services.exerciseSetsService singleton');

        var rootUrl = settings.rootUrl || '/';
        var odataUrl = getFullUrl('odata/ExerciseSets');

        return $resource("", {},
        {
            get: { method: "GET", url: odataUrl },
            save: { method: "POST", url: odataUrl },
            update: { method: 'PUT', params: { id: "@id" }, url: odataUrl + "(:id)" },
            query: { method: 'GET', params: { id: "@id" }, url: odataUrl + "(:id)" },
            remove: { method: 'DELETE', params: { id: "@id" }, url: odataUrl + "(:id)" },
            getPrevExerciseSessionId: {
                method: 'GET',
                params: {
                    exerciseId: "@exerciseId",
                    workoutSessionId: "@workoutSessionId"
                },
                url: odataUrl + "?$select=workoutSessionId&$filter=(exerciseId eq :exerciseId and workoutSessionId ne :workoutSessionId and weight gt 0)&$orderby=date desc&$top=1"
            },
            getExercisesSetsFromSession: {
                method: 'GET',
                params: {
                    exerciseId: "@exerciseId",
                    workoutSessionId: "@workoutSessionId"
                },
                url: odataUrl + "?$filter=(exerciseId eq :exerciseId and workoutSessionId eq :workoutSessionId)&$orderby=serialNumber"
            }
        });

        function getFullUrl(url) {
            return rootUrl.length > 1
                ? rootUrl + '/' + url
                : rootUrl + url;
        }
    }]);

    app.factory('workoutSessionsService', ['$resource', '$log', 'settings', 'tools',
    function workoutSessionsService($resource, $log, settings, tools) {
        $log.log('gym.services.workoutSessionsService singleton');

        var rootUrl = settings.rootUrl || '/';

        var service = $resource(getFullUrl('odata/WorkoutSessions:sessionId'), {}, {
            put: { method: 'PUT', params: { sessionId: '@id' } }
        });

        function getFullUrl(url) {
            return rootUrl.length > 1
                ? rootUrl + '/' + url
                : rootUrl + url;
        }

        function save(session) {
            if (!session.id) {
                session.id = tools.guid();
                return service.save(session);
            } else {
                return service.put({ sessionId: '(' + session.id + ')' }, session);
            }
        }

        return {
            save: save
        };
    }]);

    app.value('weatherCityId', '511196');
    app.value('weatherApiId', 'c038faa1c0c6322b27ceb7ca5f333ecf');
    app.service('weatherService', ['$http', '$log', 'weatherCityId', 'weatherApiId',
        function WeatherService($http, $log, weatherCityId, weatherApiId) {
            $log.log('WeatherService singleton');
            var urlTemplate = 'http://api.openweathermap.org/data/2.5/weather?id={0}&appid={1}';
            var url = urlTemplate
                .replace(/\{0\}/, weatherCityId)
                .replace(/\{1\}/, weatherApiId);

            function getCurrentWeather(callback) {
                $http.get(url).success(function (data) {
                    if (typeof callback !== 'undefined') {
                        callback(data);
                    }
                });
            }
            return {
                getCurrentWeather: getCurrentWeather
            };
        }]);
})();