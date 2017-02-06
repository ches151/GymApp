(function () {
    'use strict';
    angular.module('gym')
        .controller('WorkoutEditCtrl', WorkoutEditCtrl);

    WorkoutEditCtrl.$inject = ['$timeout', '$log', '$window', '$scope', '$mdConstant', '$routeParams', 'tools', 'workoutsService', 'exercisesService', 'domFactory', 'header'];
    function WorkoutEditCtrl($timeout, $log, $window, $scope, $mdConstant, $routeParams, tools, workoutsService, exercisesService, domFactory, header) {
        $log.log('gym.WorkoutEditCtrl constructor');
        
        header.canGoBack = true;
        
        var self = this;
        self.exercises = [];
        self.searchText = '';
        self.workoutId = $routeParams.workoutId;

        self.querySearch = querySearch;
        //self.deleteExercise = deleteExercise;
        self.transformChip = transformChip;
        self.saveWorkout = saveWorkout;

        self.workout = {
            exercises: []
        };

        workoutsService
            .get(function (data) {
                self.exercises = data.value;
            });

        workoutsService
            .query({ id: self.workoutId }, function (data) {
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
            if (canSave(self.workout)) {
                setWorkoutNameIfEmpty(self.workout);

                // ODATA doesn't allow updating child collections, so we will cover this in several steps instead:
                // 1. update workout name
                // 2. update $ref
                delete self.workout.exercises;

                workoutsService
                    .update({ id: self.workout.id }, self.workout, function () {
                        redirectToListOfWorkouts();
                        // TODO Scroll created workout into view
                    });
            }
            else {
                // TODO: show a toast message 'workout was not saved'
                redirectToListOfWorkouts();
            }
        }

        function redirectToListOfWorkouts() {
            $scope.go('workout-list');
        }

        function setWorkoutNameIfEmpty(workout) {
            if (typeof workout.name === 'undefined' || workout.name === '') {
                workout.name = 'Workout ' + (new Date())
                    .toISOString()
                    .replace('T', ' ')
                    .replace(/\.\d+Z$/i, '');
            }
        }

        function canSave(workout) {
            return (workout.name !== '' || (typeof workout.exercises !== 'undefined' && workout.exercises.length > 0));
        }
    }
})();
