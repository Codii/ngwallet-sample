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
			link: ($scope, el, attrs) ->

				console.log("test")
				$scope.expenses = []

				$rootScope.$on "wallet:update", ->
					$wallet.getExpenses().then (expenses) -> $scope.expenses = expenses

				newEl = angular.element($templateCache.get("WalletHistory"))
				el.replaceWith $compile(newEl)($scope)
]