"use strict"
angular.module("app").config([
	##################
	# General routes #
	##################
	'$stateProvider'
	($stateProvider) ->
		$stateProvider.state 'root',
			url : ''
			views :
				"" :
					templateUrl : 'RootCtrl'
					controller  : 'RootCtrl'

		return
])
