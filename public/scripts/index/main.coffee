# Bootstrap angular

define ['angular', 'polymer','index/app'], (angular, polymer, app) ->
	$html = angular.element(document.getElementsByTagName('html')[0])
	angular.element().ready () -> angular.resumeBootstrap([app['name']])