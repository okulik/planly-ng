(function() {
  'use strict';

  angular.module('planlyApp')
    .controller('UserRegistrationsCtrl', ['$scope', '$location', '$auth', function ($scope, $location, $auth) {
      $scope.$on('auth:registration-email-error', function(ev, reason) {
        $scope.error = reason.errors;
      });
      $scope.handleRegBtnClick = function() {
        $auth.submitRegistration($scope.registrationForm)
          .then(function(/*resp*/) {
            $auth.submitLogin({
              email: $scope.registrationForm.email,
              password: $scope.registrationForm.password
            });
          })
          .catch(function(/*resp*/) {
          });
      };
    }]);
})();