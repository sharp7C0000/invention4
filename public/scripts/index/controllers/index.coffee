# Sample index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->
	$scope.welcomeMessage = "index page"
	$scope.$apply() 
]