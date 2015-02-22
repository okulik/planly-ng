(function() {
  'use strict';
 
  angular.module('planlyApp')
    .controller('TripNewCtrl', ['$scope', '$rootScope', 'Trip', '$location',
      function ($scope, $rootScope, Trip, $location) {
        $scope.createNewTrip = function () {
          new Trip($scope.newTripForm).create();
          $location.path('/trips');
        };
    }]);
})();
