(function () {
    "use strict";
    angular.module("gym")
        .controller("WorkoutNewController", WorkoutNewController);

    WorkoutNewController.$inject = ["$timeout", "$log", "$window", "$scope", "$mdConstant", "tools", "workoutService", "domFactory", "header"];
    function WorkoutNewController($timeout, $log, $window, $scope, $mdConstant, tools, workoutService, domFactory, header) {
        $log.log("gym.WorkoutNewController constructor");
        
        header.title = "New workout";        
        header.canGoBack = true;

        var self = this;
        self.exercises = [];
        self.searchText = "";
        self.selectedItem = null;

        self.querySearch = querySearch;
        self.transformChip = transformChip;
        self.saveWorkout = saveWorkout;

        $scope.newWorkout = {
            exercises: []
        };

        workoutService
            .getExercises()
            .success(function getExercisesCallback(data) {
                if (typeof data === "undefined" || typeof data.value === "undefined") {
                    $log.error("No exercises");
                }
                self.exercises = data.value;
            });

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
            // Otherwise, create a new one
            return {
                name: chip,
                //type: 'new',
                id: tools.guid()
            };
        }

        function saveWorkout() {
            if (canSave()) {
                var newWorkoutId = tools.guid();
                $scope.newWorkout.id = newWorkoutId;
                setWorkoutNameIfEmpty($scope.newWorkout);
                
                workoutService
                    .addWorkout($scope.newWorkout)
                    .success(function (data) {
                        redirectToListOfWorkouts();
                        // TODO Scroll created workout into view
                    });
            }
            else {
                // TODO: show a toast message "workout was not saved"
                redirectToListOfWorkouts();
            }
        }

        function redirectToListOfWorkouts() {
            $scope.go("workout-list");
        }
        
        function setWorkoutNameIfEmpty(workout) {
            if (typeof workout.name === "undefined" || workout.name === "") {
                workout.name = "Workout "+(new Date())
                    .toISOString()
                    .replace("T"," ")
                    .replace(/\.\d+Z$/i, "");
            }
        }
        
        function canSave() {
            var workout = $scope.newWorkout;
            return (workout.name !== "" || (typeof workout.exercises !== "undefined" && workout.exercises.length > 0));
        }
    }
})();
