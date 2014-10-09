"use strict"

angular.module('directives').directive 'walletHistory', [
	'$rootScope'
	'$compile'
	'$modal'
	'$templateCache'
	'WalletService'
	($rootScope, $compile, $modal, $templateCache, $wallet) ->
		{} =
			restrict    : 'E'
			scope       : false
			replace     : true
			templateUrl : 'WalletHistory'
			link: ($scope, el, attrs) ->

				$scope.expenses = []

				refresh = ->
					$wallet.getExpenses().then (expenses) -> $scope.expenses = expenses

				$rootScope.$on "storage:persist", -> refresh()
]