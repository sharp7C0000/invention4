# Bootstrap angular

define [
	'angular'
	'blog_read_post/app'
	'socjs'
	'css!../../css/blog'
	'css!../../css/blog/read_post'
], (angular, app) ->
	$html = angular.element(document.getElementsByTagName('html')[0])
	angular.element().ready () -> angular.resumeBootstrap([app['name']])
