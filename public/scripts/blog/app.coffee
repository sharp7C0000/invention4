# Load angular related files

define ['angular', 'blog/controllers'
], (angular, controllers) ->
	angular.module('invention4', ['invention4.controllers'])