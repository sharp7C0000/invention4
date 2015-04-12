# Bootstrap angular

define [
	'angular'
	'admin_new_post/app'
	'css!../../css/admin'
	'css!../../css/admin_new_post'
], (angular, app) ->
	$html = angular.element(document.getElementsByTagName('html')[0])
	angular.element().ready () -> angular.resumeBootstrap([app['name']])