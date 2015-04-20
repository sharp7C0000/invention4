# admin index controller

define ["shared/controllers/form"], (formCtrl) -> [ "$scope", "$http", ($scope, $http) ->

	# contents field only error message
	contentsErrorMessages = {
		required : "Contents required"
	}

	invalid = () ->
		if !$scope.targetForm.contents.$valid && $scope.targetForm.contents.$dirty && $scope.targetForm.title.$valid
			document.querySelector('#content-invalid').open()

	submitSuccess = (data, status, headers, config) -> 
		window.location = data.data.redirectUrl

	submitError = (data, status, headers, config) ->
		if data.error?
			error = data.error

			# handling database error
			if error.type == "DATABASE_ERROR"
				$scope.formData.valid.global = true
				$scope.formData.error.global = "Database error occured"				

	# extend common form controller
	angular.extend(this, new formCtrl($scope, $http, submitSuccess, submitError, invalid))

	$scope.targetForm = $scope.newPostForm

	$scope.cancel = (url) -> window.location = url

	# get contents field error message
	$scope.contentsErrorMessage = (error) ->
		message = ""
		angular.forEach error, (v, k) ->
			if v
				if contentsErrorMessages[k]?
					message = contentsErrorMessages[k]
				else
					message = "validation error: " + k
		message

	$scope.$apply()
]