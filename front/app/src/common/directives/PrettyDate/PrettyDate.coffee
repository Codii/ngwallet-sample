"use strict"
module = angular.module 'directives'

module.directive 'prettyDate', [
	'$timeout'
	'I18nSrvc'
	($timeout, I18n) ->
		link = (scope, elem, attrs) ->
			setDate = ->
				if scope.date?
					momentDate = moment(scope.date.getTime())

					if attrs.notimezone?
						momentDate.subtract("minutes", -(momentDate.zone())) if momentDate.zone() < 0
						momentDate.add("minutes", momentDate.zone()) if momentDate.zone() > 0

					currentDate = moment()

					diffWithCurrent = moment.duration(currentDate.valueOf() - momentDate.valueOf())

					if diffWithCurrent.days() < 7 and diffWithCurrent.days() > -7 and diffWithCurrent.months() == 0 and diffWithCurrent.years() == 0
						scope.shortDate = momentDate.fromNow()
					else
						scope.shortDate = momentDate.format("L")

					scope.fullDate = momentDate.format("LLL")

				else
					$timeout setDate, 200
				return

			setDate()
			return

		{} =
			link:        link
			replace:     true
			restrict:    'EA'
			scope:       { date: "=" }
			templateUrl: "PrettyDate"
]
