rhubarbApp = angular.module('rhubarbApp', ['ngRoute'])


rhubarbApp.config ($routeProvider) ->
  $routeProvider
    .when('/', templateUrl: 'views/subscribe.html', controller: 'MainController')
    .when('/unsubscribe/:id', templateUrl: 'views/unsubscribe.html', controller: 'UnsubscribeController')
    .otherwise redirectTo: '/'
  return

rhubarbApp.directive 'autoFocus', ($timeout) ->
  {
    restrict: 'AC'
    link: (_scope, _element) ->
      $timeout (->
        _element[0].focus()
        return
      ), 0
      return
  }

rhubarbApp.controller 'MainController', ($scope, $http) ->
  $scope.email = ''
  $scope.toastText = "Won't send unrequested emails"
  $scope.buttonText = "Signup for monthly emails"
  $scope.showList = false
  $scope.forms = {}
  $scope.items = []

  $scope.ok = ->
    $scope.email && $scope.forms.signup.email.$valid

  $scope.notOk = ->
    $scope.forms.signup.email.$invalid

  $scope.getItems = ->
    req =
      method: 'GET'
      url: '/rhubarb_item.json'

    $http(req).success((data) ->
      $scope.items = data
    ).error((data) ->
      console.log data
    )

  $scope.subscribe = ->
    req =
      method: 'POST'
      url: '/rhubarb_user.json'
      data:
        email: $scope.email

    $http(req).success((data) ->
      console.log data
    ).error((data) ->
      console.log data
      $scope.forms.signup.email.$invalid = true

      if data.error.indexOf('unique') != -1
        $scope.buttonText = 'Email already registered'
    )

  $scope.fruitText = (hovered) ->
    if hovered then 'rhubarb' else 'strawberry'

  $scope.getItems()

  return

rhubarbApp.controller 'UnsubscribeController', ($scope, $http, $routeParams) ->

  $scope.ok = ->
    $scope.email && $scope.forms.signup.email.$valid

  $scope.notOk = ->
    $scope.forms.signup.email.$invalid

  $scope.unsubscribe = ->
    req =
      method: 'DELETE'
      url: '/rhubarb_user.json'
      data:
        id: $routeParams.id
        email: $scope.email

    $http(req).success((data) ->
      console.log data
    ).error((data) ->
      console.log data
      $scope.forms.signup.email.$invalid = true
      # if data.error.indexOf('found') != -1
        # $scope.buttonText = 'Email already registered'
    )

  return
