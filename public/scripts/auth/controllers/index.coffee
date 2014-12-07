# Sample index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	# initialize form data
	$scope.formData = {}
	$scope.formData.error = {}
	$scope.formData.valid = {
		username: false
		password: false
	}

	resetValidation= () ->
		$scope.formData.error = {}
		$scope.formData.valid = {
			username: false
			password: false
		}
	
	$scope.submit = (url) ->
		resetValidation()

		console.log $scope.formData.username
		console.log $scope.formData.password
		console.log "click submit " + url

		$http.post(url, $scope.formData)
		.success((data, status, headers, config) -> 
			window.location = "/admin"
			console.log "success"
		)
		.error((data, status) -> 
			console.log "error", data, status

			if data.error?
				error = data.error

				if error.type == "INVALID_FORM"
					angular.forEach error.contents, (v, k) ->
						#$scope.formData.valid[v.field] = true
						$scope.formData.valid.global = true
						$scope.formData.error.global = v.text
		)
	
	$scope.$apply()
]