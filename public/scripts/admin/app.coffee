# Load angular related files

define ['angular', 'admin/controllers'
], (angular, controllers) ->
	angular.module('invention4', ['invention4.controllers'])