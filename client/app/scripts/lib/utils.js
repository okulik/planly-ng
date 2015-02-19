(function() {
  'use strict';

  angular.module('planlyApp')
    .factory('Utils', [function() {
      var utils = {};
      var milliInDay = 1000*60*60*24;

      utils.daysToTrip = function(date) {
        var days = Math.ceil((Date.parse(date) - Date.now()) / milliInDay);
        if (days <= 0) {
          return 'past';
        }
        else {
          return days;
        }
      };

      utils.isDateInFuture = function(date) {
        var days = Math.ceil((Date.parse(date) - Date.now()) / milliInDay);
        if (days <= 0) {
          return false;
        }
        return true;
      };

      utils.displayDays = function(days) {
        if (days <= 0) {
          return "";
        }
        else {
          return days;
        }
      };

      return utils;
    }]);
})();