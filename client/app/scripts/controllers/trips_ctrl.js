/*global $ */
(function() {
  'use strict';
   
  angular.module('planlyApp')
    .controller('TripsCtrl', ['$scope', '$rootScope', '$location', '$http', '$compile', '$timeout', '$q', 'Trip', 'Utils', 'ModalService', 'Constants', function ($scope, $rootScope, $location, $http, $compile, $timeout, $q, Trip, Utils, ModalService, Constants) {
      Trip.query().then(function(trips) {
        $scope.trips = trips;
      }, function() {
        $location.path('/');
        return;
      });

      $scope.utils = Utils;
      $scope.constants = Constants;

      $scope.editTrip = function(trip) {
        $location.path('trip_details/' + trip.tid);
      };

      $scope.createNewTrip = function() {
        $location.path('trip_new');
      };

      $scope.deleteTrip = function(trip, index) {
        ModalService.showModal({
          templateUrl: 'views/modals/delete_trip.html',
          controller: 'YesNoCtrl',
          title: 'Delete',
          inputs: { title: 'Delete',
            text: 'Do you really want to delete trip "' + trip.destination + ', ' + trip.comment + '"?' }
        }).then(function(modal) {
          modal.element.modal();
          modal.close.then(function(result) {
            if (result) {
              Trip.get({tid: trip.tid}).then(function(tr) {
                tr.delete().then(function() {
                  $scope.trips.splice(index, 1);
                });
              });
            }
          });
        });
      };

      $scope.getNextMonthTrips = function() {
        return $q(function(resolve, reject) {
          Trip.getNextMonthTrips().then(function(trips) {
            resolve({ trips: trips });
          }, function(reason) {
            reject(reason);
          });
        });
      };

      $scope.filterTrips = function(destination) {
        if (destination && destination.length > 0) {
          $scope.filtering = true;
          Trip.filter({destination: destination}).then(function(trips) {
            $scope.trips = trips;
          });
        }
        else {
          $scope.filtering = false;
          Trip.query().then(function(trips) {
            $scope.trips = trips;
          });
        }
      };

      $scope.resetFilter = function() {
        $scope.destination = '';
        $scope.filtering = false;
        Trip.query().then(function(trips) {
          $scope.trips = trips;
        });
      };

      $scope.printTemplate = function(templateUrl, dataPromise) {
        dataPromise.then(function(data) {
          $http.get(templateUrl).success(function(template) {
            var printScope = angular.extend($rootScope.$new(), data);
            var element = $compile($('<div>' + template + '</div>'))(printScope);
            var waitForRenderAndPrint = function() {
              if (printScope.$$phase || $http.pendingRequests.length) {
                $timeout(waitForRenderAndPrint);
              }
              else {
                printHtml(element.html());
                printScope.$destroy();
              }
            };
            waitForRenderAndPrint();
          });
        });
      };

      var printHtml = function(html) {
        var hiddenFrame = $('<iframe style="display: none"></iframe>').appendTo('body')[0];
        hiddenFrame.contentWindow.printAndRemove = function() {
          hiddenFrame.contentWindow.print();
          hiddenFrame.contentWindow.onafterprint = function() {
            $(hiddenFrame).remove();
          };
        };
        var htmlDocument = '<!doctype html>' +
          '<html>' +
            '<head>' +
              '<title>Planly, plan your trips!</title>' +
              '<link rel="stylesheet" href="styles/main.css">' +
            '</head>' +
            '<body onload="printAndRemove();">' + // Print only after document is loaded
                html +
            '</body>'+
          '</html>';
        var doc = hiddenFrame.contentWindow.document.open('text/html', 'replace');
        doc.write(htmlDocument);
        doc.close();
      };
    }]);
})();