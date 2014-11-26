# Load angular related files

define ['angular', 'auth/controllers', 'ng-polymer-elements'
], (angular, controllers, ngPolymer) ->
	angular.module('invention4', ['invention4.controllers', 'ng-polymer-elements'])