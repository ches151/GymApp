(function () {
    "use strict";
    angular.module("gym")
    .controller("WorkoutListCtrl", WorkoutListCtrl);
    WorkoutListCtrl.$inject = ["$timeout", "$log", "$scope", "tools", "workoutsService", "domFactory", "header"];
    function WorkoutListCtrl($timeout, $log, $scope, tools, workoutsService, domFactory, header) {
        $log.log("gym.WorkoutListCtrl constructor");
        
        header.title = "Gym App";
        header.canGoBack = false;

        var self = this;
        self.workouts = [];

        self.deleteWorkout = deleteWorkout;

        workoutsService
            .get(function(data) {
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
            workoutsService.remove({ id: workout.id });
        }
    }

})();