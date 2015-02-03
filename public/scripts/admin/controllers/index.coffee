# admin index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	console.log "index!"

	$scope.$apply()
]