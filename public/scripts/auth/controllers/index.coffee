# Sample index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	# initialize form data
	$scope.formData = {}
	$scope.formData.error = {}
	$scope.formData.valid = {
		username: false
		password: false
	}

	# client side form message
	errorMessages = {
		required : "This field is required"
		maxlength: "The value is too long"
		minlength: "The value is too short"
	}

	# get clientside error message
	$scope.errorMessage = (error) ->
		message = ""
		angular.forEach error, (v, k) ->
			if v
				if errorMessages[k]?
					message = errorMessages[k]
				else
					message = "validation error: " + k
		message

	resetValidation = () ->
		$scope.formData.error = {}
		$scope.formData.valid = {
			username: false
			password: false
		}
		$scope.hideGlobalValidation()

	$scope.hideGlobalValidation = () -> 
		$scope.formData.valid.global = false

	$scope.submit = (url) ->
		resetValidation()

		form = $scope.loginForm
		form.username.$dirty = true
		form.password.$dirty = true

		if not form.$invalid
			# submit server
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
							$scope.formData.valid.global = true
							$scope.formData.error.global = v.text
			)
	
	$scope.$apply()
]