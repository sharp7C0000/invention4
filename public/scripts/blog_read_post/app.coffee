# Load angular related files

define ['angular', 'blog_read_post/controllers', 'social'
], (angular, controllers, social) ->
	angular.module('invention4', ['invention4.controllers', 'socialLinks'])
