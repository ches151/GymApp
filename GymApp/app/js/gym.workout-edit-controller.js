(function () {
    "use strict";
    angular.module("gym")
        .controller("WorkoutEditCtrl", WorkoutEditCtrl);

    WorkoutEditCtrl.$inject = ["$timeout", "$log", "$window", "$scope", "$mdConstant", "$routeParams", "tools", "workoutsService", "domFactory", "header"];
    function WorkoutEditCtrl($timeout, $log, $window, $scope, $mdConstant, $routeParams, tools, workoutsService, domFactory, header) {
        $log.log("gym.WorkoutEditCtrl constructor");
        
        header.canGoBack = true;
        
        var self = this;
        self.exercises = [];
        self.searchText = "";
        self.workoutId = $routeParams.workoutId;

        self.querySearch = querySearch;
        self.keydown = keydown;
        //self.deleteExercise = deleteExercise;
        self.transformChip = transformChip;
        self.saveWorkout = saveWorkout;

        self.workout = {
            exercises: []
        };

        workoutsService
            .getExercises()
            .success(function getExercisesCallback(data) {
                self.exercises = data.value;
            });

        workoutsService
            .getWorkoutById(self.workoutId)
            .success(function getWorkoutByIdCallback(data) {
                setWorkout(data);
            });
            
        function setWorkout(workout) {
            self.workout = workout;
            header.title = self.workout.name;
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
        /**
        * Return the proper object when the append is called.
        */
        function transformChip(chip) {
            // If it is an object, it's already a known chip
            if (angular.isObject(chip)) {
                return chip;
            }
            // Otherwise, create a edit one
            return {
                name: chip,
                //type: 'edit',
                id: tools.guid()
            };
        }

        function saveWorkout() {
            redirectToListOfWorkouts();
            throw "Not implemented";
        }

        function redirectToListOfWorkouts() {
            $scope.go("workout-list");
        }

        function keydown(event) {
            console.log("keydown");
            switch (event.keyCode) {
                case $mdConstant.KEY_CODE.ENTER:
                    $log.log("Create edit " + self.searchText);
                    var w = self.workout;
                    if (w) {
                        if (!w.exercises) {
                            w.exercises = [];
                        }
                        var name = self.searchText;
                        var noSuchExerciseYet =
                        w.exercises.every(function (element) {
                            return element.name !== name;
                        });
                        if (noSuchExerciseYet) {
                            var editExercise = {
                                id: tools.guid(),
                                name: name
                            };
                            self.exercises.push(editExercise);
                            w.exercises.push(editExercise);
                            $log.log(w);
                        }
                        self.searchText = "";
                    }
                    break;
                default:
            }
        }
    }
})();
