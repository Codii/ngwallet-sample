"use strict"
module = angular.module('directives')

module.directive 'priceInput', [
	() ->
		linkFn = ($scope, elem, attrs) ->

			$scope.checkAmount = ->

			$scope.$watch "amount", (n, o) ->
				$scope.checkAmount()

		{} =
			restrict    : "E"
			scope       : { amount: "=" }
			replace     : true
			link        : linkFn
			templateUrl : 'PriceInput'
]