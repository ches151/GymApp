(function () {
    "use strict";
    angular.module("gym")
        .controller("WorkoutSessionController", WorkoutSessionController);

    WorkoutSessionController.$inject = ["$timeout", "$log", "$window", "$scope", "$mdConstant", "$routeParams", "tools", "workoutService", "domFactory", "header", "massUnits"];
    function WorkoutSessionController($timeout, $log, $window, $scope, $mdConstant, $routeParams, tools, workoutService, domFactory, header, massUnits) {
        $log.log("gym.WorkoutSessionController constructor");

        header.canGoBack = true;

        var self = this;

        self.workoutId = $routeParams.workoutId;
        self.dateStart = (new Date()).toISOString();
        self.workout = {};
        self.activeExercise = {};
        self.exercises = [];
        self.exerciseSets = [];
        self.workoutSession = {};
        self.massUnits = massUnits;
        self.setActiveExercise = setActiveExercise;
        self.onKeydown = onKeydown;

        workoutService
            .getWorkoutById(self.workoutId)
            .success(function getWorkoutByIdCallback(workout) {
                setWorkout(workout);
                //setWorkoutSession(workout);
                setExerciseSets(workout);
                setActiveExercise(self.exercises[0]);
            });

        function setWorkout(workout) {
            header.title = workout.name;
            self.workout = workout;
            self.exercises = workout.exercises;
        }

        function setExerciseSets(workout) {
            var sets = [];
            workout.exercises.forEach(function (ex, index) {
                sets.push([new ExerciseSet({
                    id: tools.guid(),
                    exercise: ex,
                    workout: workout,
                    weight: null,
                    unit: 1,
                    serialNumber: index,
                    numberOfRepetitions: null
                })]);
            }, this);


            
            self.exerciseSets = sets;
            sets = null;
        }

        function setWorkoutSession(workout) {
            // self.workoutSession = {
            //     id: tools.guid(),
            //     dateStart: new Date(),
            //     dateEnd: null,
            //     //exerciseSets: self.exerciseSets
            // };
        }

        function setActiveExercise(exercise) {
            //TODO write down date of the last set of the current exercise
            self.activeExercise = exercise;
        }

        function onKeydown(event, exerciseIndex) {
            switch (event.keyCode) {
                case $mdConstant.KEY_CODE.ENTER:
                case $mdConstant.KEY_CODE.TAB:
                $log.log(event.keyCode);
                    addOneMoreSet(exerciseIndex);
                    break;
                default:
            }
        }
        
        function addOneMoreSet(exerciseIndex) {
            var set = self.exerciseSets[exerciseIndex];
            var lastSet = set[set.length - 1];
            if (isSetFilled(set)) {
                lastSet.date = new Date();
                $log.log(lastSet);
                set.push(new ExerciseSet({
                    id: tools.guid(),
                    exercise: lastSet.exercise,
                    workout: lastSet.workout,
                    weight: null,
                    unit: lastSet.unit,
                    serialNumber: set.length,
                    numberOfRepetitions: null
                }));
            }
        }

        function isSetFilled(set) {
            if (!set) {
                return false;
            }
            return set.every(function (exSet) {
                $log.log(exSet);
                return exSet.weight && exSet.numberOfRepetitions
            }, this);
        }
    }

    function ExerciseSet(args) {
        this.id = args.id;
        this.date = args.date;
        this.rowVersion = args.rowVersion;
        this.exercise = args.exercise;
        this.workout = args.workout;
        this.weight = args.weight;
        this.unit = args.unit;
        this.serialNumber = args.serialNumber;
        this.numberOfRepetitions = args.numberOfRepetitions;
    }
})();
