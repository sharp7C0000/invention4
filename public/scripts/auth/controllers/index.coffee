# Sample index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	# initialize form data
	$scope.formData = {}
	$scope.formData.error = {}
	$scope.formData.valid = {
		username: false
		password: false
	}

	errorMessages = {
		required: "This field is required"
		maxlength: "too long username"
	}

	$scope.errorMessage = (error) ->
		message = ""
		angular.forEach error, (v, k) ->
			if v
				if errorMessages[k]?
					message = errorMessages[k]
				else
					message = "validation error: " + k
		message

	resetValidation= () ->
		$scope.formData.error = {}
		$scope.formData.valid = {
			username: false
			password: false
		}
	
	$scope.submit = (url) ->
		resetValidation()

		# client side validation
		console.log "v", $scope.loginForm

		form = $scope.loginForm
		#$scope.loginForm.username.$valid = true
		#console.log $scope.loginForm.username.$valid
		if form.$invalid
			# client validation error
			angular.forEach form.$error, (v, k) ->


		else
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
							#$scope.formData.valid[v.field] = true
							$scope.formData.valid.global = true
							$scope.formData.error.global = v.text
			)
	
	$scope.$apply()
]