'use strict'

(angular.module 'coretrackerApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'ui.bootstrap',
  'coretracker.factories',
  'coretracker.services'
])
  .config ($routeProvider)->
    $routeProvider
      .when('/', 
        templateUrl: 'views/main.html'
        controller: 'MainCtrl as mainCtrl')
      .otherwise (redirectTo: '/')

