# Load angular related files

define ['angular', 'admin_setting/controllers'
], (angular, controllers) ->
	angular.module('invention4', ['invention4.controllers'])
