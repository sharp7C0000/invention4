# Sample index controller

define ['polymer'], () -> [ "$scope", "$http", ($scope, $http) ->
	$scope.welcomeMessage = "index page"
	$scope.$apply() 
]