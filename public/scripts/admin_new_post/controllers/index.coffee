# admin index controller

define ["shared/controllers/form"], (formCtrl) -> [ "$scope", "$http", ($scope, $http) ->

	# contents field only error message
	contentsErrorMessages = {
		required : "Need to insert some contents"
	}

	invalid = () ->
		if !$scope.targetForm.contents.$valid && $scope.targetForm.contents.$dirty && $scope.targetForm.title.$valid
			document.querySelector('#content-invalid').open()

	# extend common form controller
	angular.extend(this, new formCtrl($scope, $http, null, null, invalid))

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