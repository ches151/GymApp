(function () {
    "use strict";
    angular.module("gym.directives", [])
    .directive("gFocusNextOnEnter", function () {
        return {
            restrict: "A",
            link: function ($scope, elem) {
                elem.bind("keydown", function (e) {
                    var focusables = this.form;
                    var code = e.keyCode || e.which;
                    if (code === 13) {
                        var current = Array.prototype.indexOf.call(focusables, this);
                        var next = focusables[current + 1];
                        next = next ? next : focusables[0];
                        next.focus();
                        e.preventDefault();
                    }
                });
                //elem.bind("keydown", function(e) {
                //    var focusables = jQuery("input:visible,button:visible");
                //    var code = e.keyCode || e.which;
                //    if (code === 13) {
                //        var current = focusables.index(this);
                //        var next = focusables.eq(current + 1);
                //        next = next.length ? next : focusables.eq(0);
                //        next.focus();
                //        e.preventDefault();
                //    }
                //});
            }
        };
    })
    .directive('autofocus', ['$timeout', function ($timeout) {
        return {
            restrict: 'A',
            link: function ($scope, $element) {
                $timeout(function () {
                    $element[0].focus();
                });
            }
        };
    }])
    .directive("gCurrentTime", ['$interval', 'dateFilter', function ($interval, dateFilter) {

        function link(scope, element, attrs) {
            var format,
            timeoutId;

            function updateTime() {
                element.text(dateFilter(new Date(), format));
            }

            scope.$watch(attrs.gCurrentTime, function (value) {
                format = value;
                updateTime();
            });

            element.on('$destroy', function () {
                $interval.cancel(timeoutId);
            });

            // start the UI update process; save the timeoutId for canceling
            timeoutId = $interval(function () {
                updateTime();
                // update DOM
            }, 1000);
        }

        return {
            link: link
        };
    }])
    .directive("gCustomTimer", ['$log', '$interval', 'tools', 'nonameService',
    function ($log, $interval, tools, nonameService) {
        $log.log('gym.directives.gCustomTimer constructor');


        function link(scope, element, attrs) {
            $log.log('gym.directives.gCustomTimer.link');
            var format, timeoutId;

            function updateTime() {
                var timeElapsed = new Date(new Date() - nonameService.workoutStartTime);
                element.text(tools.formatTime(timeElapsed, format));
            }

            scope.$watch(attrs.format, function (value) {
                $log.log("gym.directives.scope.$watch(attrs.format)");
                format = value;
                updateTime();
            });

            element.on('$destroy', function () {
                $interval.cancel(timeoutId);
            });

            timeoutId = $interval(updateTime, 1000);
        }

        return {
            link: link
        };
    }])
    // http://stackoverflow.com/a/19628104/5910706
    .directive("gLoadingIndicator", ['$log', '$http', '$animate', '$timeout', function ($log, $http, $animate, $timeout) {
        return {
            restrict: 'A',
            link: function (scope, elem, attrs) {
                var timeoutId, delay;

                scope.isLoading = function () {
                    return $http.pendingRequests.length > 0;
                };

                scope.$watch(attrs.gLoadingIndicator, function (value) {
                    var v = parseInt(value);
                    delay = !isNaN(v) ? v : 200;
                });

                scope.$watch(scope.isLoading, function (value) {
                    if (value) {
                        $log.info('show');
                        timeoutId = $timeout(() => {
                            $log.log('timeout elapsed');
                            $animate.removeClass(elem, 'ng-hide');
                        }, delay);
                    }
                    else {
                        $log.info('hide');
                        $timeout.cancel(timeoutId);
                        $animate.addClass(elem, 'ng-hide');
                    }
                });
            }
        };
    }])
    .directive("gWeather", ['$interval', 'weatherService', 'tools', function ($interval, weatherService, tools) {

        function link(scope, element) {
            var timeoutId;
            var weatherImgUrlTemplate = 'http://openweathermap.org/img/w/{0}.png';
            var weatherImgUrl = '';

            update();

            function update() {
                weatherService.getCurrentWeather(function getCurrentWeatherCallback(weatherData) {
                    console.log(weatherData);
                    var weather = weatherData.weather.length && weatherData.weather[0];
                    if (weather) {
                        weatherImgUrl = weatherImgUrlTemplate.replace(/\{0\}/i, weather.icon);
                    }
                    var temp = weatherData.main.temp - 273.15;
                    element.html(tools.formatStr('<span>{0} °C</span>', temp));
                });
            }

            element.on('$destroy', function () {
                $interval.cancel(timeoutId);
            });

            // start the UI update process; save the timeoutId for canceling
            timeoutId = $interval(function () {
                update();
                // update DOM
            }, 600000);
        }

        return {
            link: link
        };
    }
    ]);
})();
