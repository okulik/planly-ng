(function() {
  'use strict';
   
  angular.module('planlyApp')
    .controller('TripDetailsCtrl', ['$scope', '$rootScope', 'Trip', '$location', '$routeParams',
      function ($scope, $rootScope, Trip, $location, $routeParams) {
        Trip.get({tid: $routeParams.id}).then(function(trip) {
          $scope.trip = trip;
        }, function() {
          $location.path('/trips');
        });

        $scope.updateTrip = function () {
          $scope.trip.update().then(function() {
            $location.path('/trips');
          });
        };
    }]);
})();