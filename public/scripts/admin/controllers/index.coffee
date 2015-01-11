# admin index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	console.log "scope"
	
	$scope.dropdown = ($event) ->
		console.log "toggle", angular.element($event.target).parent().find("paper-dropdown")[0].toggle
		angular.element($event.target).parent().find("paper-dropdown")[0].toggle()

	$scope.$apply()
]