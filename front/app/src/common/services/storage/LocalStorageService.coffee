"use strict"

angular.module('services').factory 'LocalStorageService', [
	'$rootScope'
	'$q'
	'$timeout'
	($rootScope, $q, $t) ->

		###
		# This is a dummy implementation of a localstorage based "datastore"
		# for mockup purposes
		###

		window.localStorage;

		dbName = 'walletDb'

		db = {}

		updateWalletBalance = ->
			db.accounts[0].balance = _.reduce(db.expenses, ((s, e) -> s + parseFloat(e.amount)), 0)

		persistDatabase = ->
			updateWalletBalance()
			window.localStorage.setItem(dbName, JSON.stringify(db))
			$rootScope.$broadcast "storage:persist"

		initDummy = ->
			db.expenses = [
				{
					title: 'Deposit'
					amount: 150
					date: new Date()
				}
				{
					title: 'House Rent'
					amount: -850
					date: new Date()
				}
				{
					title: 'Work Angel October Paycheck'
					amount: 7250.25
					date: new Date()
				}
				{
					title: 'Gaumont Theater tickets'
					amount: -68
					date: new Date()
				}
			]


		## Init of datastore
		_db = window.localStorage.getItem(dbName)
		debugger
		if _db
			db = JSON.parse(_db)
		else
			db = expenses: [], accounts: [balance: 0]
			initDummy()
			persistDatabase()

		{} =
			getWalletAccount: ->
				df = $q.defer()

				df.resolve(db.accounts[0])

				df.promise

			addWalletExpense: (expense) ->
				df = $q.defer()

				expense = angular.extend
					amount: 0
					date: Date()
					title: "Untitled"
				, expense

				db.expenses.push(expense)

				persistDatabase()

				df.resolve(expense)

				df.promise

			resetWalletAccount: ->
				df = $q.defer()

				# reset store
				db = expenses: [], accounts: [balance: 0]

				initDummy()
				persistDatabase()

				df.resolve(db.accounts[0])

				df.promise

			getWalletExpenses: ->
				df = $q.defer()

				result = _.sortBy(db.expenses, 'date').reverse()

				df.resolve(result)

				df.promise

]