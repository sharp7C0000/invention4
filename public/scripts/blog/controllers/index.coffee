# Sample index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	$scope.clickPagenator = (url) ->
		window.location = url

	$scope.$apply()
]
