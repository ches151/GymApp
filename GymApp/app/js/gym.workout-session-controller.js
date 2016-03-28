(function () {
    'use strict';
    angular.module('gym')
        .controller('WorkoutSessionCtrl', WorkoutSessionCtrl);

    WorkoutSessionCtrl.$inject = ['$log', '$mdConstant', '$routeParams', '$scope', '$mdDialog', '$q', 'tools', 'header', 'massUnits', 'workoutsService', 'exerciseSetsService', 'workoutSessionsService'];
    function WorkoutSessionCtrl($log, $mdConstant, $routeParams, $scope, $mdDialog, $q, tools, header, massUnits, workoutsService, exerciseSetsService, workoutSessionsService) {
        $log.log("gym.WorkoutSessionCtrl constructor");

        header.canGoBack = true;

        var self = this;

        self.workoutId = $routeParams.workoutId;
        self.workout = {};
        self.workoutSession = null;

        /* MODEL properties */
        self.activeExercise = {};       // View: to expand current exercise        
        self.exercises = [];            // View: list of exercises        
        self.exerciseSets = [];         // View: list of sets of exercises        
        self.massUnits = massUnits;     // View: dropdown list


        self.setActiveExercise = setActiveExercise;
        self.showHistory = showHistory;
        self.onKeydown = onKeydown;
        self.onBlur = onBlur;

        $scope.$on('$destroy', onDestroy);


        workoutsService
            .getWorkoutById(self.workoutId)
            .success(onWorkoutObtained);
        
        function onWorkoutObtained(workout) {
            setWorkout(workout);
            setWorkoutSession(workout);
            setExerciseSets(workout);
            setActiveExercise(self.exercises[0]);
        }

        function setWorkout(workout) {
            header.title = workout.name;
            self.workout = workout;
            self.exercises = workout.exercises;
        }

        function setWorkoutSession() {
            self.workoutSession = new WorkoutSession({
                dateStart: new Date(),
                dateEnd: null
            });
            workoutSessionsService.save(self.workoutSession);
        }

        function onDestroy() {
            endWorkoutSession();
        }

        function endWorkoutSession() {
            self.workoutSession.dateEnd = new Date();
            workoutSessionsService.save(self.workoutSession);
        }

        function setExerciseSets(workout) {
            var sets = [];
            var workoutSessionId = self.workoutSession.id;
            workout.exercises.forEach(function (ex, index) {
                sets.push([new ExerciseSet({
                    exerciseId: ex.id,
                    workoutId: workout.id,
                    workoutSessionId: workoutSessionId,
                    weight: null,
                    unit: 'kg',
                    serialNumber: index,
                    numberOfRepetitions: null
                })]);
            });

            self.exerciseSets = sets;
            sets = null;
        }

        function setActiveExercise(exercise) {
            self.activeExercise = exercise;
        }

        function showHistory(ev, exercise) {
            var workoutSessionId = self.workoutSession.id;
            var exerciseName = exercise.name;
            getExerciseHistory(exercise.id, workoutSessionId)
            .then(function (exerciseSets) {
                $mdDialog.show({
                    controller: ExerciseSetOneExerciseCtrl,
                    controllerAs: 'ctrl',
                    templateUrl: 'app/partials/exerciseset-one-exercise.html',
                    parent: angular.element(document.body),
                    targetEvent: ev,
                    clickOutsideToClose: true,
                    fullscreen: false,
                    locals: {
                        exerciseSets: exerciseSets,
                        exerciseName: exerciseName
                    }
                });
            }, function onReject(data) { $log.warn(data.message); });
        }

        function getExerciseHistory(exerciseId, workoutSessionId) {
            var deferred = $q.defer();
            exerciseSetsService.getPrevExerciseSessionId({
                exerciseId: exerciseId,
                workoutSessionId: workoutSessionId
            },
            function (data) {
                if (data && data.value && data.value.length) {
                    exerciseSetsService.getExercisesSetsFromSession({
                        exerciseId: exerciseId,
                        workoutSessionId: data.value[0].workoutSessionId
                    },
                    function (data) {
                        if (data && data.value && data.value.length) {
                            deferred.resolve(data.value);
                        } else {
                            deferred.reject({ message: 'No previous exercise sets are available'});
                        }
                    });
                }
            });
            return deferred.promise;
        }

        function onKeydown(event, exerciseIndex) {
            switch (event.keyCode) {
                case $mdConstant.KEY_CODE.ENTER:
                case $mdConstant.KEY_CODE.TAB:
                    addOneMoreSet(exerciseIndex);
                    break;
                default:
            }
        }

        function addOneMoreSet(exerciseIndex) {
            var currentExerciseSets = self.exerciseSets[exerciseIndex];

            if (areAllExerciseSetsFilled(currentExerciseSets)) {
                var lastSet = currentExerciseSets[currentExerciseSets.length - 1];
                lastSet.date = new Date();
                var workoutSessionId = self.workoutSession.id;

                currentExerciseSets.push(new ExerciseSet({
                    exerciseId: lastSet.exerciseId,
                    workoutId: lastSet.workoutId,
                    workoutSessionId: workoutSessionId,
                    weight: null,
                    unit: lastSet.unit,
                    serialNumber: currentExerciseSets.length,
                    numberOfRepetitions: null
                }));
            }
        }

        function onBlur(event, exerciseIndex, set) {
            if (isSetFilled(set)) {
                saveExerciseSet(set);
            } else if (isSetEmpty(set)) {
                deleteExerciseSet(exerciseIndex, set);
            }
        }

        function saveExerciseSet(set) {
            if (!set.id) {
                set.id = tools.guid();
                return exerciseSetsService.save(set);
            } else {
                return exerciseSetsService.update(set);
            }
        }

        function deleteExerciseSet(exerciseIndex, set) {
            var setId = set.id;
            if (setId) {
                exerciseSetsService.remove(setId);
            }

            var currentExerciseSets = self.exerciseSets[exerciseIndex];
            if (currentExerciseSets.length > 1) {
                var index = currentExerciseSets.indexOf(set);
                currentExerciseSets.splice(index, 1);
            }
        }

        function areAllExerciseSetsFilled(sets) {
            if (!sets) {
                return false;
            }
            return sets.every(function (set) {
                return isSetFilled(set);
            });
        }
        function isSetFilled(set) {
            return set.weight > 0 && set.numberOfRepetitions > 0;
        }
        function isSetEmpty(set) {
            return !set.weight && !set.numberOfRepetitions;
        }
    }
    angular.module('gym')
        .controller('ExerciseSetOneExerciseCtrl', ExerciseSetOneExerciseCtrl);

    ExerciseSetOneExerciseCtrl.$inject = ['$mdDialog', 'exerciseName', 'exerciseSets'];
    function ExerciseSetOneExerciseCtrl($mdDialog, exerciseName, exerciseSets) {
        var self = this;
        self.exerciseName = exerciseName;
        self.exerciseSets = exerciseSets;
        self.hide = function () {
            $mdDialog.hide();
        };
        self.cancel = function () {
            $mdDialog.cancel();
        };
    }

    function ExerciseSet(args) {
        this.id = args.id;
        this.date = args.date;
        this.rowVersion = args.rowVersion;
        this.exerciseId = args.exerciseId;
        this.workoutId = args.workoutId;
        this.workoutSessionId = args.workoutSessionId;
        this.weight = args.weight;
        this.unit = args.unit;
        this.serialNumber = args.serialNumber;
        this.numberOfRepetitions = args.numberOfRepetitions;
    }

    function WorkoutSession(args) {
        this.id = args.id;
        this.dateStart = args.dateStart;
        this.dateEnd = args.dateEnd;
        this.rowVersion = args.rowVersion;
        this.exerciseSets = args.exerciseSets;
    }
})();
