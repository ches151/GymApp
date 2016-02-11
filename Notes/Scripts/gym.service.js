(function() {
    "use strict";
    var app = angular.module("gym.service", ["tools"]);
    app.factory('domFactory', ["$window", "$document", "$timeout", "$location", "$anchorScroll", "tools",
    function($window, $document, $timeout, $location, $anchorScroll, tools) {
        return {
            setFocus: function(id) {
                // timeout makes sure that it is invoked after any other event has been triggered.
                // e.g. click events that need to run before the focus or
                // inputs elements that are in a disabled state but are enabled when those events
                // are triggered.
                $timeout(function() {
                    var element = $window.document.getElementById(id);
                    if (element)
                        element.focus();
                });
            },
            launchFullscreen: function() {
                tools.enterFullscreen($document[0].documentElement);
            },
            exitFullscreen: function() {
                tools.exitFullscreen();
            },            
            scrollElementIntoView: function(id) {
                $location.hash(id);                
                $anchorScroll();
            }
        };
    }]);

    app.service("workoutService", ["$http", "$log", "settings", "tools", WorkoutService]);
    
    function WorkoutService($http, $log, settings, tools) {
        $log.log("WorkoutService singleton");
        
        var rootUrl = settings.rootUrl || "/";
        var workouts;
        var exercises;
        var newWorkout = {};
        
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
            $http.get(getFullUrl("odata/Workouts?$expand=exercises")).success(function(data) {
                workouts = data.value;
                if (typeof callback !== "undefined") {
                    callback(workouts);
                }
            });
        }
        function getExercises(callback) {
            $http.get(getFullUrl("odata/Exercises?")).success(function(data) {
                exercises = data.value;
                if (typeof callback !== "undefined") {
                    callback(exercises);
                }
            });
        }
//         function getExercises(callback) {
//             if (!workouts) {
//                 getWorkouts(function() {
//                     exercises = getExercisesFromWorkouts(workouts);
//                     if (typeof callback !== "undefined") {
//                         callback(exercises);
//                     }
//                 });
//             } 
//             else {
//                 exercises = getExercisesFromWorkouts(workouts);
//                 if (typeof callback !== "undefined") {
//                     callback(exercises);
//                 }
//             }
//         }
//         function getExercisesFromWorkouts(workouts) {
//             var r = [], index = {};
//             for (var i = 0; i < workouts.length; i++) {
//                 var workout = workouts[i];
//                 workout.exercises.forEach(function (exercise, j){
//                     if (!index[exercise.id]) {
//                         r.push(exercise);
//                         index[exercise.id] = exercise;
//                     }
//                 });
//             }
//             index = null;
//             r.sort(function(a, b){
//                 if(a.name < b.name) return -1;
//                 if(a.name > b.name) return 1;
//                 return 0;
//             });
//             return r;
//         }
        
        function deleteWorkoutById(workoutId) {
            $http.delete(getFullUrl("odata/Workouts("+workoutId+")")).success(function(data) {
                $log.log("deleted workout with id=" + workoutId);
            });
        }
        
        function addWorkout(newWorkout) {
            $log.info("%cTODO push new exercises to DB", "color:blue");
            $http.post(getFullUrl("odata/Workouts?$expand=exercises"), newWorkout).success(function(data) {
                $log.log(data);
                $log.log("added workout:", newWorkout);
            });
        }
        
        return {
            getWorkoutsAsync: getWorkouts,
            getExercisesAsync: getExercises,
            deleteWorkoutById: deleteWorkoutById,
            addWorkout: addWorkout
        };
    }
    app.value("weatherCityId", "511196");
    app.value("weatherApiId", "c038faa1c0c6322b27ceb7ca5f333ecf");
    app.service("weatherService", ["$http", "$log", "weatherCityId", "weatherApiId",
    function WeatherService($http, $log, weatherCityId, weatherApiId){
        $log.log("WeatherService singleton");
        var urlTemplate = "http://api.openweathermap.org/data/2.5/weather?id={0}&appid={1}";
        var url = urlTemplate
            .replace(/\{0\}/, weatherCityId)
            .replace(/\{1\}/, weatherApiId);

        function getCurrentWeather(callback){
            $http.get(url).success(function(data) {
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