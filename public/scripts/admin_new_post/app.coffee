# Load angular related files

define ['angular', 'admin_new_post/controllers', 'directives'
], (angular, controllers, directives) ->
	angular.module('invention4', ['invention4.controllers', 'invention4.directives'])