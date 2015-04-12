# Load angular related files

define ['angular', 'admin_new_post/controllers', 'lib/angular-directives/editor'
], (angular, controllers, editorDirectives) ->
	angular.module('invention4', ['invention4.controllers', 'invention4.directives.editor'])