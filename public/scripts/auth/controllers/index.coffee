# Sample index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->
	$scope.welcomeMessage = "auth page"
	$scope.$apply() 
]