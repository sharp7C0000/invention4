# Load angular related files

define ['angular', 'admin_setting/controllers', 'directives', 'ngHolder'
], (angular, controllers, directives, Holder, ngHolder) ->
	console.log "holder", Holder
	angular.module('invention4', ['invention4.controllers', 'invention4.directives', 'ngHolder'])
