"use strict"

angular.module('services').factory 'LocalStorageService', [
	'$rootScope'
	'$q'
	($rootScope, $q) ->

		###
		# This is a dummy implementation of a localstorage based database
		# for mockup purposes
		###

		dbName = 'walletDb'

		db = {}

		if dbName in window.localStorage
			db = window.localStorage.getItem(dbName)
		else
			db = expenses: [], accounts: [balance: 0]

		persistDatabase = ->
			window.localStorage.setItem(dbName, JSON.stringify(db))

		updateWalletBalance = ->
			db.accounts[0].balance = _.reduce(db.expenses, ((s, e) ->
				s + parseFloat(e.amount)
			), 0)

		$rootScope.$on "$routeChangeStart", ->
			console.log("persisting")
			persistDatabase()

		{} =
			getWalletAccount: ->
				df = $q.defer()

				df.resolve(db.accounts[0])

				df.promise

			addWalletExpense: (expense) ->
				df = $q.defer()

				db.expenses.push(expense)
				updateWalletBalance()

				df.resolve(expense)

				df.promise

			getWalletExpenses: ->
				df = $q.defer()

				df.resolve(db.expenses)

				df.promise

]