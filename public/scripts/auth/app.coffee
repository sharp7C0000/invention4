# Load angular related files

define ['angular', 'auth/controllers'
], (angular, controllers) ->
	angular.module('invention4', ['invention4.controllers'])