'use strict';

var app = angular.module('pageViewStatsApp', ['ngResource', 'ngRoute']);

app.config(['$routeProvider', '$locationProvider',
  function($routeProvider, $locationProvider) {
    $routeProvider.
      when('/top_urls', {
        templateUrl: '/templates/index.html.erb',
        controller: 'TopUrlCtrl'
      }).
      when('/top_referrers', {
        templateUrl: '/templates/top_referrers.html.erb',
        controller: 'TopReferrerCtrl'
      }).
      otherwise({
        redirectTo: '/top_urls'
      });
  }]);

app.controller('TopUrlCtrl', function($scope, $resource) {
    var top_urls_data_resource = $resource('/api/top_urls');
    $scope.top_urls = top_urls_data_resource.get();
});

app.controller('TopReferrerCtrl', function($scope, $resource) {
    var top_referrers_data_resource = $resource('/api/top_referrers');
    $scope.top_referrers = top_referrers_data_resource.get();
});
