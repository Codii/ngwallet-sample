"use strict"
angular.module('controllers').controller 'RootCtrl', [
	'$scope'
	'$rootScope'
	'$injector'
	'$state'
	'WalletService'
	($scope, $rootScope, $injector, $state, $wallet) ->
		$state.go 'root.index'

		$scope.resetData = -> $wallet.reset()
]

