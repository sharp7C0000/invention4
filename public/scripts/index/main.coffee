# Bootstrap angular

define ['angular', 'index/app', 'css!../../css/blog/style'], (angular, app) ->
	$html = angular.element(document.getElementsByTagName('html')[0])
	angular.element().ready () -> angular.resumeBootstrap([app['name']])