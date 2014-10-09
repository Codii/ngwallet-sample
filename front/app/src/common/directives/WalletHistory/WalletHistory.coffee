"use strict"

angular.module('directives').directive 'walletHistory', [
	'$rootScope'
	'$compile'
	'$modal'
	'$timeout'
	'WalletService'
	($rootScope, $compile, $modal, $t, $wallet) ->
		{} =
			restrict    : 'E'
			scope       : false
			replace     : true
			templateUrl : 'WalletHistory'
			link: ($scope, el, attrs) ->

				$scope.expenses = []

				refresh = ->
					console.log "here refreshing"
					$wallet.getExpenses().then (expenses) -> $scope.expenses = expenses

				$t -> refresh()

				$scope.$on "storage:persist", -> refresh()
]