# admin topmenu controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	$scope.dropdown = ($event) ->
		angular.element($event.target).parent().find("paper-dropdown")[0].toggle()

	$scope.home = () -> window.location = "/"

	$scope.logout = (url) ->
		# submit server
		$http.delete(url)
		.success((data, status, headers, config) -> 
			window.location = data.data.redirectUrl
		)
		.error((data, status) -> 
			console.log "error", data, status
			# TODO
			# toasting error message
		)

	$scope.$apply()
]