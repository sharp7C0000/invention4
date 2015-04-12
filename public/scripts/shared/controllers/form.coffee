# common form controller

define [], ($scope, $http) ->

	# submitSuccess (optional) : success callback
	# submitError   (optional) : error callback
	formCtrl = ($scope, $http, submitSuccess, submitError) ->

		# initialize form data
		$scope.formData       = {}
		$scope.formData.error = {}
		$scope.formData.valid = {}

		# TODO: seperate this at other file
		# client side form message 
		errorMessages = {
			required : "This field is required"
			maxlength: "The value is too long"
			minlength: "The value is too short"
		}

		#### private

		# reset form validation
		resetValidation = () ->
			$scope.hideGlobalValidation()
			$scope.formData.error = {}
			$scope.formData.valid = {}

		#### public

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

		# hide global validation
		$scope.hideGlobalValidation = () -> 
			$scope.formData.valid.global = false

		$scope.submit = (url) ->
			console.log "formdata", $scope.formData

			resetValidation()

			form = $scope.targetForm
			
			# set dirty all field
			angular.forEach form, (v, k) ->
				if typeof v == "object"
					v.$dirty = true if v.$dirty?

			if not form.$invalid
				# submit server
				$http.post(url, $scope.formData)
				.success((data, status, headers, config) ->
					console.log "success", data, status, headers, config

					submitSuccess(data, status, headers, config) if submitSuccess?
				)
				.error((data, status) -> 
					console.log "error", data, status

					if data.error?
						error = data.error

						if error.type == "INVALID_FORM"
							angular.forEach error.contents, (v, k) ->
								$scope.formData.valid.global = true
								$scope.formData.error.global = v.text

						submitError(data, status) if submitError?
				)

		$scope.$apply()

	formCtrl