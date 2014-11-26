# Sample index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	$scope.formData = {}
	
	$scope.submit = (url) ->
		console.log $scope.formData.username
		console.log $scope.formData.password
		console.log "click submit " + url

		$http.post(url, $scope.formData)
		.success((data, status, headers, config) -> 
			window.location = "/admin"
			console.log "success"
		)
		.error((data, status) -> console.log "error")
	
	$scope.$apply()
]