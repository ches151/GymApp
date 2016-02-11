(function() {
    "use strict";
    angular.module("gym", ["tools", "gym.service", "gym.directive"]);
})();
(function() {
    "use strict";
    angular.module("gym")
    .run(function($log) {
        $log.log("gym.run");
    })
    .controller("WorkoutController", WorkoutController);
    function WorkoutController($timeout, $log, $scope, tools, workoutService, domFactory) {
        $log.log("gym.WorkoutController constructor");
        
        var self = this;
        self.workouts = [];
        self.fullscreen = false;
        $scope.newWorkout = {
            exercises: []
        };
        $scope.creatingNewWorkout = false;
        
        self.deleteWorkout = deleteWorkout;
        self.startCreatingNewWorkout = startCreatingNewWorkout;
        self.saveWorkout = saveWorkout;
        self.toggleFullScreen = toggleFullScreen;
        
        workoutService.getWorkoutsAsync(function getWorkoutsAsyncCallback(workouts) {
            self.workouts = workouts;
        });

        function toggleFullScreen(){
            if (self.fullscreen = !self.fullscreen){
                domFactory.launchFullscreen();    
            }
            else {
                domFactory.exitFullscreen();
            }
        }
        
        function deleteWorkout(workout) {
            for (var i = 0; i < self.workouts.length; i++) {
                if (self.workouts[i].id === workout.id) {
                    self.workouts.splice(i, 1);
                    break;
                }
            }
            workoutService.deleteWorkoutById(workout.id);
        }
        function startCreatingNewWorkout() {
            $scope.creatingNewWorkout = true;
            domFactory.setFocus("workoutName");
        }
        function saveWorkout() {
            if ($scope.creatingNewWorkout) {
                $scope.creatingNewWorkout = false;
                var newWorkoutId = tools.guid();
                $scope.newWorkout.id = newWorkoutId;
                $log.log($scope.newWorkout);
                self.workouts.push($scope.newWorkout);
                workoutService.addWorkout($scope.newWorkout);
                $timeout(function() {
                    domFactory.scrollElementIntoView(newWorkoutId);
                });
            }
            
            $scope.newWorkout = {
                name: "",
                exercises: []
            };
        }
    }
    WorkoutController.$inject = ["$timeout", "$log", "$scope", "tools", "workoutService", "domFactory"];

})();
(function() {
    "use strict";
    angular.module("gym")
    .controller("ExerciseController", ExerciseController);
    function ExerciseController($log, $window, $scope, $mdConstant, tools, workoutService) {
        $log.log("gym.ExerciseController constructor");
        
        var self = this;
        self.exercises = [];
        self.newCardExerciseId = "newCardExercise";
        self.searchText = "";
        self.selectedItem = null;
        
        self.querySearch = querySearch;
        self.selectedItemChange = selectedItemChange;
        self.keydown = keydown;
        //self.deleteExercise = deleteExercise;
        self.transformChip = transformChip;
        
        workoutService.getExercisesAsync(function getExercisesAsyncCallback(exercises) {
            self.exercises = exercises;
        });
        
        function keydown(event) {
            switch (event.keyCode) {
            case $mdConstant.KEY_CODE.ENTER:
                $log.log("Create new " + self.searchText);
                var w = $scope.newWorkout;
                if (w) {
                    if (!w.exercises) {
                        w.exercises = [];
                    }
                    var name = self.searchText;
                    var noSuchExerciseYet = 
                    w.exercises.every(function(element, index, array) {
                        return element.name !== name;
                    });
                    if (noSuchExerciseYet) {
                        var newExercise = {
                            id: tools.guid(),
                            name: name
                        };
                        self.exercises.push(newExercise);
                        w.exercises.push(newExercise);
                        $log.log(w);
                    }
                    self.searchText = "";
                    self.selectedItem = null;
                }
                break;
            default:
            }
        }
        
        function querySearch(query) {
            var results = query 
            ? self.exercises.filter(createFilterFor(query)) 
            : self.exercises;
            return results;
        }
        
        /**
         * Create filter function for a query string
         */
        function createFilterFor(query) {
            var lowercaseQuery = angular.lowercase(query);
            
            return function filterFn(exercise) {
                return angular.lowercase(exercise.name).indexOf(lowercaseQuery) !== -1;
            };
        }
        
        function selectedItemChange(item) {
            if (item) {
                item && $log.info('Item changed to ' + item.name);
                var w = $scope.newWorkout;
                if (w) {
                    if (!w.exercises) {
                        w.exercises = [];
                    }
                    var name = item.name;
                    var noSuchExerciseYet = 
                    w.exercises.every(function(element, index, array) {
                        return element.name !== name;
                    });
                    if (noSuchExerciseYet) {
                        w.exercises.push(item);
                        $log.log(w);
                    }
                    self.searchText = "";
                    self.selectedItem = null;
                }
            }
        }
        /**
        * Return the proper object when the append is called.
        */
        function transformChip(chip) {
            // If it is an object, it's already a known chip
            if (angular.isObject(chip)) {
                return chip;
            }
            // Otherwise, create a new one
            return {
                name: chip,
                //type: 'new',
                id: tools.guid()
            };
        }
    }
    ExerciseController.$inject = ["$log", "$window", "$scope", "$mdConstant", "tools", "workoutService"];
})();
