# Load angular related files

define ['angular', 'index/controllers'], (angular, controllers) ->
	angular.module('invention4', ['invention4.controllers'])