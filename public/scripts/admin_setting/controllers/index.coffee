# admin index controller

define ["shared/controllers/form", "holderjs"], (formCtrl) -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

	submitSuccess = (data, status, headers, config) ->
		$scope.saveSuccess = true

	submitError = (data, status, headers, config) ->
		if data.error?
			error = data.error

			# handling database error
			if error.type == "DATABASE_ERROR"
				$scope.formData.valid.global = true
				$scope.formData.error.global = "Database error occured"

	# extend common form controller
	angular.extend(this, new formCtrl($scope, $http, submitSuccess, submitError))

	$scope.targetForm = $scope.settingForm

	$scope.submitForm = (url) ->
		postPerPage = document.querySelector("[name='postPerPage']").selected
		$scope.formData.postPerPage = postPerPage
		$scope.saveSuccess = false
		$scope.submit(url)

	# update profile photo
	$rootScope.$on('updateProfilePhoto', (event, message) ->
    $scope.formData.profilePhotoUrl = message
  )

	$scope.clickPhotoEdit = () ->
		$rootScope.$emit('profilePhotoDialog', $scope.formData.profilePhotoUrl)

	$scope.$apply()
]
