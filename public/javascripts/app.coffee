rhubarbApp = angular.module('rhubarbApp', [])

rhubarbApp.controller 'MainController', ($scope) ->
  $scope.email = ''
  $scope.forms = {}

  $scope.ok = ->
    $scope.email && $scope.forms.signup.email.$valid

  $scope.notOk = ->
    $scope.forms.signup.email.$invalid

  $scope.subscribe = ->
    console.log $scope.email

  return
