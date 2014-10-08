"use strict"
angular.module('controllers').controller 'RootCtrl', [
	'$scope'
	'$rootScope'
	'$injector'
	'$state'
	($scope, $rootScope, $injector, $state) ->
		$state.go 'root.index'
]

