(function() {
  'use strict';
 
  angular.module('planlyApp')
    .controller('TripNewCtrl', ['$scope', '$rootScope', 'Trip', '$location',
      function ($scope, $rootScope, Trip, $location) {
        $scope.createNewTrip = function () {
          /*jshint camelcase: false */
          $scope.newTripForm.user_id = $rootScope.user.id;
          new Trip($scope.newTripForm).create();
          $location.path('/trips');
        };
    }]);
})();