(function() {
  'use strict';

  angular.module('planlyApp')
    .controller('YesNoCtrl', ['$scope', 'close', 'title', 'text', function($scope, close, title, text) {
      $scope.close = function(result) {
        close(result, 500); // close, but give 500ms for bootstrap to animate
      };

      $scope.title = title;
      $scope.text = text;
    }]);
})();