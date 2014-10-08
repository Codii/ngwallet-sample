"use strict"
###
# Internal modules creation
###
angular.module 'services', []
angular.module 'filters', []
angular.module 'models', []
angular.module 'mixins', []
angular.module 'directives', []
angular.module 'templates', []
angular.module 'controllers', ['mixins', 'models', 'services']

###
# Loads application modules
###
app = angular.module 'app', [
	# External modules dependancies
	'ngCookies'
	'ui.bootstrap'
	'ui.utils'
	'ui.router'

	# Internal modules dependancies
	'services'
	'filters'
	'models'
	'directives'
	'controllers'
	'templates'
	'env'
]

###
# Services providers configuration
###
app.run [
	'$rootScope'
	'$state'
	'$stateParams'
	'$http'
	'$location'
	($rootScope, $state, $stateParams, $http, $location) ->

		return
]
