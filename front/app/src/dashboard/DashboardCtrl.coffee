"use strict"
angular.module('controllers').controller 'DashboardCtrl', [
	'$scope'
	'$rootScope'
	'$injector'
	'WalletService'
	($scope, $rootScope, $injector, $wallet) ->

		$scope.walletBalance = 0

		$scope.refreshBalance = ->
			$wallet.getBalance().then (balance) ->
				$scope.walletBalance = parseFloat(balance)

		$scope.refreshBalance()

		$scope.$on "storage:persist", ->
			$scope.refreshBalance()

		$scope.addRandomExpense = ->
			$wallet.addExpense title: "random", amount: 3.0
]
