/* global angular */
/* global jQuery */

(function () {
    "use strict";
    angular
    .module("gym", ["ngResource", "ngMaterial", "ngRoute", "ngAnimate", "ui.bootstrap", "tools", "gym.services", "gym.directives"])
    .config(["$routeProvider", "$mdThemingProvider", "$mdIconProvider"
    , function ($routeProvider, $mdThemingProvider, $mdIconProvider) {

        $mdThemingProvider
            .theme('default')
            .primaryPalette('blue-grey')
            .accentPalette('pink');

        $routeProvider
          .when('/', {
              templateUrl: 'partials/workout-list.html',
              controller: 'WorkoutListController',
              controllerAs: 'ctrl'
          })
          .when('/workouts', {
              templateUrl: 'partials/workout-list.html',
              controller: 'WorkoutListController',
              controllerAs: 'ctrl'
          })
          .when('/workouts/:workoutId', {
              templateUrl: 'partials/workout-edit.html',
              controller: 'WorkoutEditController',
              controllerAs: 'ctrl'
          })
          .when('/workout-new', {
              templateUrl: 'partials/workout-new.html',
              controller: 'WorkoutNewController',
              controllerAs: 'ctrl'
          })
          .when('/workout-session/:workoutId', {
              templateUrl: 'partials/workout-session.html',
              controller: 'WorkoutSessionController',
              controllerAs: 'ctrl'
          })
          .otherwise({
              redirectTo: '/workouts'
          });
    }])
    .constant("settings", {
        rootUrl: "//192.168.100.2/Notes",
        appName: "My First App"
    })
    .run(function ($log) {
        $log.log("gym.run");
    });
})();
(function () {
    "use strict";
    angular.module("gym")
    .controller("MainController", ["$log", "$scope", "$location", "$window", "domFactory", "header", 
    function MainController($log, $scope, $location, $window, domFactory, header) {
        $log.log("gym.MainController constructor");
        
        var self = this;
        self.toggleFullScreen = toggleFullScreen;
        self.fullscreen = false;        
        self.getPageTitle = getPageTitle;
        self.canGoBack = canGoBack;
        self.goBack = goBack;
        
        $scope.go = go;

        function toggleFullScreen() {
            if (self.fullscreen = !self.fullscreen) {
                domFactory.launchFullscreen();
            }
            else {
                domFactory.exitFullscreen();
            }
        }
        
        function getPageTitle() {
            return header.title;
        }
        
        function canGoBack() {
            return header.canGoBack;
        }
        
        function goBack() {
            $window.history.back();
        }
        
        function go(url){
            $location.path(url);
        }
    }]);
})();