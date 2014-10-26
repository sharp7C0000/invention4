# Sample index controller

define ["poly.core.header_panel"], () -> [ "$scope", "$http", ($scope, $http) ->
	$scope.welcomeMessage = "index page"
	$scope.$apply() 
]