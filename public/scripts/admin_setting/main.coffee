# Bootstrap angular

define [
	'angular'
	'admin_setting/app'
	'css!../../css/admin'
], (angular, app) ->
	$html = angular.element(document.getElementsByTagName('html')[0])
	angular.element().ready () -> angular.resumeBootstrap([app['name']])