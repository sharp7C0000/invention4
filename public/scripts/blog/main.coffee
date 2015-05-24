# Bootstrap angular

define ['angular', 'blog/app', 'css!../../css/blog'], (angular, app) ->
	$html = angular.element(document.getElementsByTagName('html')[0])
	angular.element().ready () -> angular.resumeBootstrap([app['name']])