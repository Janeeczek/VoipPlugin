
'use strict';
var exec = require('cordova/exec');

var VoipPlugin = (function () {
    function VoipPlugin() {
        var _this = this;
        console.log('VoipPlugin: has been created');
    }
    VoipPlugin.prototype.receiveCall = function (CallerName,successCallback, errorCallback) {
            return cordova.exec(successCallback, errorCallback, "VoipPlugin", "receiveCall", [CallerName]);
    };
   
    return VoipPlugin;
}());

var VOP = new VoipPlugin();

module.exports = VOP;


