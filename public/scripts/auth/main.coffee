# Bootstrap angular

define [
	'angular'
	'auth/app'
	'css!../../css/admin'
	'css!../../css/admin/auth'
], (angular, app) ->
	$html = angular.element(document.getElementsByTagName('html')[0])
	angular.element().ready () -> angular.resumeBootstrap([app['name']])