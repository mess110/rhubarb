rhubarbApp = angular.module('rhubarbApp', [])

rhubarbApp.controller 'MainController', ($scope) ->
  $scope.email = ''

  $scope.subscribe = ->
    console.log $scope.email

  return
