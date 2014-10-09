"use strict"

angular.module('services').factory 'WalletService', [
	'$rootScope'
	'$q'
	'StorageService'
	($rootScope, $q, $storage) ->

		{} =
			getBalance: ->
				df = $q.defer()

				$storage.get().getWalletAccount().then (account) ->
					console.log arguments
					df.resolve account.balance

				df.promise


			addExpense: (expense) ->
				$storage.get().addWalletExpense(expense).then ->
					$rootScope.$broadcast "wallet:update"

			getExpenses: ->
				$storage.get().getWalletExpenses()

]