'use strict';

angular.module('angularBlogApp')

.controller('MainCtrl', ['$scope','NuxeoDirectory', function ($scope, NuxeoDirectory) {
  $scope.awesomeThings = [
    'HTML5 Boilerplate',
    'AngularJS',
    'Karma' 
  ];

  $scope.continents = NuxeoDirectory("continent").query()
}]);
