"use strict"

angular.module('services').factory 'StorageService', [
	'$rootScope'
	'$q'
	'LocalStorageService'
	($rootScope, $q, LocalStorageService) ->

		{} =
			get: -> LocalStorageService

]