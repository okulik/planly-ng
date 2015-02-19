(function () {
  'use strict';

  var app = angular.module('planlyApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ng-token-auth',
    'bgf.paginateAnything',
    'angularModalService',
    'ui.date',
    'ui.router',
    'rails'
  ]);

  app.config(['$routeProvider', function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .when('/trips', {
        templateUrl: 'views/trips.html',
        controller: 'TripsCtrl'
      })
      .when('/trip_details/:id', {
        templateUrl: 'views/trip_details.html',
        controller: 'TripDetailsCtrl'
      })
      .when('/trip_new', {
        templateUrl: 'views/trip_new.html',
        controller: 'TripNewCtrl'
      })
      .when('/sign_in', {
        templateUrl: 'views/user_sessions/new.html',
        controller: 'UserSessionsCtrl'
      })
      .when('/register', {
        templateUrl: 'views/user_registrations/new.html',
        controller: 'UserRegistrationsCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  }]);

  app.config(['railsSerializerProvider', function(railsSerializerProvider) {
    railsSerializerProvider.underscore(angular.identity).camelize(angular.identity);
  }]);

  app.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.headers.common = { 'Accept':
      'application/vnd.trips+json; version=1' };
  }]);

  app.run(['$rootScope', '$location', function($rootScope, $location) {
    $rootScope.$on('auth:login-success', function(ev, user) {
      $rootScope.user = user;
      $location.path('/trips');
    });
    
    $rootScope.$on('auth:logout-success', function() {
      $rootScope.user = null;
      $location.path('/');
    });
  }]);
})();