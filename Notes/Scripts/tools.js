(function() {
    angular.module("tools", [])
    .factory("tools", ["$document", function tools($document) {
        return {
            json: {
                retrocycle: function retrocycle($) {
                    'use strict';
                    
                    var cache = {};
                    
                    $ = (function rez(value) {
                        
                        var i, item, name, id, ref, values;
                        
                        if (value && typeof value === 'object') {
                            id = value.$id;
                            ref = value.$ref;
                            values = value.$values;
                            if (typeof id === 'string') {
                                if (values && typeof values === 'object' && Object.prototype.toString.apply(values) === '[object Array]') {
                                    value = values;
                                    cache[id] = value;
                                    delete value.$id;
                                    if (Object.prototype.toString.apply(value) === '[object Array]') {
                                        for (i = 0; i < value.length; i += 1) {
                                            item = value[i];
                                            value[i] = rez(item);
                                        }
                                    }
                                    return value;
                                } 
                                else {
                                    cache[id] = value;
                                    delete value.$id;
                                    for (name in value) {
                                        if (typeof value[name] === 'object') {
                                            item = value[name];
                                            value[name] = rez(item);
                                        }
                                    }
                                    return value;
                                }
                            } else if (typeof ref === 'string') {
                                value = cache[ref];
                                return value;
                            }
                        } else {
                            return value;
                        }
                    }($));
                    cache = null;
                    return $;
                }
            
            },
            enterFullscreen: function enterFullscreen(element) {
                if (element.requestFullScreen) {
                    element.requestFullScreen();
                } else if (element.mozRequestFullScreen) {
                    element.mozRequestFullScreen();
                } else if (element.webkitRequestFullScreen) {
                    element.webkitRequestFullScreen();
                }
            },
            exitFullscreen: function exitFullscreen() {
                if ($document[0].exitFullscreen) {
                    $document[0].exitFullscreen();
                } else if ($document[0].mozCancelFullScreen) {
                    $document[0].mozCancelFullScreen();
                } else if ($document[0].webkitExitFullscreen) {
                    $document[0].webkitExitFullscreen();
                } else if ($document[0].msExitFullscreen) {
                    $document[0].msExitFullscreen();
                }
            },
            
            guid: function guid() {
                function s4() {
                    return Math.floor((1 + Math.random()) * 0x10000)
                    .toString(16)
                    .substring(1);
                }
                return s4() + s4() + '-' + s4() + '-' + s4() + '-' + 
                s4() + '-' + s4() + s4() + s4();
            },
            formatStr: function(str) {
                var args = Array.prototype.slice.call(arguments, 1);
                return str.replace(/{(\d+)}/g, function(match, number) {
                    return typeof args[number] !== 'undefined' 
                    ? args[number] 
                    : match;
                });
            }
        };
    }
    ]);
})();
