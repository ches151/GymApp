(function () {
    'use strict';
    angular.module('gym')
        .controller('WorkoutNewCtrl', WorkoutNewCtrl);

    WorkoutNewCtrl.$inject = ['$timeout', '$log', '$window', '$scope', '$mdConstant', 'tools', 'workoutsService', 'exercisesService', 'domFactory', 'header'];
    function WorkoutNewCtrl($timeout, $log, $window, $scope, $mdConstant, tools, workoutsService, exercisesService, domFactory, header) {
        $log.log('gym.WorkoutNewCtrl constructor');
        
        header.title = 'New workout';        
        header.canGoBack = true;

        var self = this;
        self.exercises = [];
        self.searchText = '';
        self.selectedItem = null;

        self.querySearch = querySearch;
        self.transformChip = transformChip;
        self.saveWorkout = saveWorkout;

        $scope.newWorkout = {
            exercises: []
        };

        exercisesService
            .get(function (data) {
                if (typeof data === 'undefined' || typeof data.value === 'undefined') {
                    $log.error('No exercises');
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
            if (canSave($scope.newWorkout)) {
                var newWorkoutId = tools.guid();
                $scope.newWorkout.id = newWorkoutId;
                setWorkoutNameIfEmpty($scope.newWorkout);
                
                workoutsService
                    .save($scope.newWorkout, function () {
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
                workout.name = 'Workout '+(new Date())
                    .toISOString()
                    .replace('T',' ')
                    .replace(/\.\d+Z$/i, '');
            }
        }
        
        function canSave(workout) {
            return (workout.name !== '' || (typeof workout.exercises !== 'undefined' && workout.exercises.length > 0));
        }
    }
})();
