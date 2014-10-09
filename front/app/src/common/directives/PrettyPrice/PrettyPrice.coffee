"use strict"
module = angular.module('directives')

module.directive 'prettyPrice', [
	() ->

		formatPrice = (val) ->
			(parseFloat(val) || 0).toFixed(2)

		linkFn = ($scope, elem, attrs) ->

		{} =
			restrict    : "A"
			require			: "?ngModel"
			replace     : true
			link        : linkFn
			templateUrl : 'PrettyPrice'
]