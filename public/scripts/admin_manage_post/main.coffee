# Bootstrap angular

define [
	'angular'
	'admin_manage_post/app'
], (angular, app) ->
	$html = angular.element(document.getElementsByTagName('html')[0])
	angular.element().ready () -> angular.resumeBootstrap([app['name']])
