(function () {
    "use strict";
    angular.module("gym")
    .controller("WorkoutListController", WorkoutListController);
    WorkoutListController.$inject = ["$timeout", "$log", "$scope", "tools", "workoutService", "domFactory", "header"];
    function WorkoutListController($timeout, $log, $scope, tools, workoutService, domFactory, header) {
        $log.log("gym.WorkoutListController constructor");
        
        header.title = "Gym App";
        header.canGoBack = false;

        var self = this;
        self.workouts = [];

        self.deleteWorkout = deleteWorkout;

        workoutService
            .getWorkouts()
            .success(function getWorkoutsCallback(data) {
                    self.workouts = data.value;
                });

        function deleteWorkout(workout) {
            // TODO add toast UNDO message
            for (var i = 0; i < self.workouts.length; i++) {
                if (self.workouts[i].id === workout.id) {
                    self.workouts.splice(i, 1);
                    break;
                }
            }
            workoutService.deleteWorkoutById(workout.id);
        }
    }

})();