'use strict';

angular.module('angularBlogApp', ['services.nuxeo'])

.constant("NUXEO_CONFIG", {
  contextPath: "/nuxeo"
})

.config(function ($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'views/main.html',
      controller: 'MainCtrl'
    })
    .otherwise({
      redirectTo: '/'
    });
});
