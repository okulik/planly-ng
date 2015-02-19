(function() {
  'use strict';

  angular.module('planlyApp')
    .factory('Trip', ['$http', 'railsResourceFactory', 'Constants', function($http, railsResourceFactory, Constants) {
      var resource = railsResourceFactory({
        url: '/api/trips',
        name: 'trip',
        httpConfig: {
          headers: {
            'Accept': 'application/vnd.trips+json; version=' + Constants.apiVersion
          }
        },
        idAttribute: 'tid'
      });

      resource.getNextMonthTrips = function() {
        return resource.$get('/api/trips/next_month');
      };

      resource.filter = function(params) {
        return resource.$get('/api/trips/filter', params);
      };

      return resource;
    }]);
})();