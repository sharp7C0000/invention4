# Bootstrap angular

define ['angular', 'blog/app'], (angular, app) ->
	$html = angular.element(document.getElementsByTagName('html')[0])
	angular.element().ready () -> angular.resumeBootstrap([app['name']])
