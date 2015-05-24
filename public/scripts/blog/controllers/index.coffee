# Sample index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->
	$scope.welcomeMessage = "blog page"
	$scope.$apply() 
]