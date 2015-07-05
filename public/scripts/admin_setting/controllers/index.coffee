# admin setting index controller

define ["shared/controllers/form", "holderjs"], (formCtrl) -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

	invalid = () ->
		# if !$scope.targetForm.contents.$valid && $scope.targetForm.contents.$dirty && $scope.targetForm.title.$valid
		# 	$rootScope.$emit('contentInvalid', $scope.contentsErrorMessage($scope.newPostForm.contents.$error))


	submitSuccess = (data, status, headers, config) ->
		#window.location = data.data.redirectUrl

	submitError = (data, status, headers, config) ->
		# if data.error?
		# 	error = data.error
		#
		# 	# handling database error
		# 	if error.type == "DATABASE_ERROR"
		# 		$scope.formData.valid.global = true
		# 		$scope.formData.error.global = "Database error occured"

	# extend common form controller
	angular.extend(this, new formCtrl($scope, $http, submitSuccess, submitError, invalid))

	$scope.targetForm = $scope.settingForm

	# update profile photo
	$rootScope.$on('updateProfilePhoto', (event, message) ->
    $scope.formData.profilePhotoUrl = message
  )

	$scope.clickPhotoEdit = () ->
		$rootScope.$emit('profilePhotoDialog', $scope.formData.profilePhotoUrl)

	$scope.submitForm = (url) ->
		postPerPage = document.querySelector("[name='postPerPage']").selected
		$scope.formData.postPerPage = postPerPage
		$scope.submit(url)

	$scope.$apply()
]
