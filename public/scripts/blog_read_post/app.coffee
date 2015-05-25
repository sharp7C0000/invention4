# Load angular related files

define ['angular', 'blog_read_post/controllers'
], (angular, controllers) ->
	angular.module('invention4', ['invention4.controllers'])
