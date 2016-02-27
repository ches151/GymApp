(function () {
    "use strict";
    var app = angular.module("gym.services", ["tools"]);
    app.factory('domFactory', ["$window", "$document", "$timeout", "$location", "$anchorScroll", "tools",
        function ($window, $document, $timeout, $location, $anchorScroll, tools) {
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
    app.factory('header', function () {
        return {
            title: "Gym App",
            canGoBack: false
        };
    });
    app.factory('massUnits', function () {
        return [
            {
                name: "kg",
                factor: 1
            },
            {
                name: "lb",
                factor: 0.453592
            }];
    });

    app.service("workoutService", ["$http", "$log", "settings", "tools", WorkoutService]);
    function WorkoutService($http, $log, settings, tools) {
        $log.log("WorkoutService singleton");

        var rootUrl = settings.rootUrl || "/";

        function getFullUrl(url) {
            return rootUrl.length > 1
                ? rootUrl + "/" + url
                : rootUrl + url;
        }

        function getWorkouts(callback) {
            //             $http.get(getFullUrl("Workouts2/List")).success(function(data) {
            //                 workouts = tools.json.retrocycle(data);
            //                 if (typeof callback !== "undefined") {
            //                     callback(workouts);
            //                 }
            //             });
            return $http.get(getFullUrl("odata/Workouts?$expand=exercises"));
        }
        function getExercises() {
            return $http.get(getFullUrl("odata/Exercises"));
        }

        function deleteWorkoutById(workoutId) {
            return $http.delete(getFullUrl("odata/Workouts(" + workoutId + ")"));
        }

        function getWorkoutById(workoutId) {
            return $http.get(getFullUrl("odata/Workouts(" + workoutId + ")?$expand=exercises"));
        }

        function addWorkout(newWorkout) {
            return $http.post(getFullUrl("odata/Workouts?$expand=exercises"), newWorkout);
        }

        return {
            getWorkouts: getWorkouts,
            getExercises: getExercises,
            addWorkout: addWorkout,
            getWorkoutById: getWorkoutById,
            deleteWorkoutById: deleteWorkoutById
        };
    }

    app.value("weatherCityId", "511196");
    app.value("weatherApiId", "c038faa1c0c6322b27ceb7ca5f333ecf");
    app.service("weatherService", ["$http", "$log", "weatherCityId", "weatherApiId",
        function WeatherService($http, $log, weatherCityId, weatherApiId) {
            $log.log("WeatherService singleton");
            var urlTemplate = "http://api.openweathermap.org/data/2.5/weather?id={0}&appid={1}";
            var url = urlTemplate
                .replace(/\{0\}/, weatherCityId)
                .replace(/\{1\}/, weatherApiId);

            function getCurrentWeather(callback) {
                $http.get(url).success(function (data) {
                    if (typeof callback !== "undefined") {
                        callback(data);
                    }
                });
            }
            return {
                getCurrentWeather: getCurrentWeather
            };
        }]);
})();