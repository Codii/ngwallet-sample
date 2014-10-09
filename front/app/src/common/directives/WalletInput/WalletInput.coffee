"use strict"

angular.module('directives').directive 'walletInput', [
	'$rootScope'
	'$compile'
	'$modal'
	'$templateCache'
	'WalletService'
	($rootScope, $compile, $modal, $templateCache, $wallet) ->
		{} =
			restrict    : 'A'
			scope       : {}
			transclude  : true
			templateUrl : 'WalletInput'
			link: ($scope, el, attrs) ->

				modalInstance = null

				$scope.expense = title: "New Expense", amount: 0.0

				$scope.resetInput = ->
					$scope.expense = title: "", amount: 0.0

				$scope.openModal = ->
					modalInstance = $modal.open(
						templateUrl: "WalletInputModal"
						scope: $scope
						windowClass: "wallet-input-modal"
					)

				$scope.submit = ->
					$wallet.addExpense(angular.copy($scope.expense))
					$scope.resetInput()
]