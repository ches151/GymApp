/* global angular */

(function () {
    'use strict';
    angular
    .module('gym', ['ngResource', 'ngMaterial', 'ngRoute', 'ngAnimate', 'tools', 'gym.services', 'gym.directives'])
    .config(['$routeProvider', '$mdThemingProvider', '$locationProvider'
    , function ($routeProvider, $mdThemingProvider, $locationProvider) {
        $mdThemingProvider
            .theme('default')
            .primaryPalette('blue-grey')
            .accentPalette('pink');

        //$locationProvider.html5Mode(true);

        $routeProvider
          .when('/', {
              templateUrl: 'app/partials/workout-list.html',
              controller: 'WorkoutListCtrl',
              controllerAs: 'ctrl'
          })
          .when('/workouts', {
              templateUrl: 'app/partials/workout-list.html',
              controller: 'WorkoutListCtrl',
              controllerAs: 'ctrl'
          })
          .when('/workouts/:workoutId', {
              templateUrl: 'app/partials/workout-edit.html',
              controller: 'WorkoutEditCtrl',
              controllerAs: 'ctrl'
          })
          .when('/workout-new', {
              templateUrl: 'app/partials/workout-new.html',
              controller: 'WorkoutNewCtrl',
              controllerAs: 'ctrl'
          })
          .when('/workout-session/:workoutId/:sessionId', {
              templateUrl: 'app/partials/workout-session.html',
              controller: 'WorkoutSessionCtrl',
              controllerAs: 'ctrl'
          })
          .otherwise({
              redirectTo: '/'
          });
    }])
    .run(['$log',function ($log) {
        $log.log('gym.run');
    }]);
})();
(function () {
    'use strict';
    angular.module('gym')
    .controller('MainCtrl', ['$log', '$scope', 'header', 
    function MainCtrl($log, $scope, header) {
        $log.log('gym.MainCtrl constructor');
        
        var self = this;
        self.toggleFullScreen = toggleFullScreen;
        self.fullscreen = false;        
        self.getPageTitle = getPageTitle;
        self.canGoBack = canGoBack;
        self.goBack = goBack;        
        $scope.go = go;

        function toggleFullScreen() {
            self.fullscreen = header.toggleFullScreen();
        }
        
        function getPageTitle() {
            return header.title;
        }
        
        function canGoBack() {
            return header.canGoBack;
        }
        
        function goBack() {
            header.goBack();
        }
        
        function go(url){
            header.go(url);
        }
    }]);
})();