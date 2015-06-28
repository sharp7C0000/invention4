# admin new post dialog controller

define ["shared/controllers/form"], (formCtrl) -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

	$scope.dialog = document.querySelector('#profile-photo-dialog')

	# extend common form controller
	angular.extend(this, new formCtrl($scope, $http))

	$scope.targetForm = $scope.profilePhotoForm

  # show photo url modal
	$rootScope.$on('profilePhotoDialog', (event, message) ->
		$scope.formData.photoUrl = message
		$scope.dialog.open()
  )

	$scope.submit = () ->

		# reset form
		$scope.formData.error = {}
		$scope.formData.valid = {}

		form = $scope.targetForm

		# set dirty all field
		angular.forEach form, (v, k) ->
			if typeof v == "object"
				v.$dirty = true if v.$dirty?

		if not form.$invalid
			$rootScope.$emit('updateProfilePhoto', $scope.formData.photoUrl)
			# close dialog
			$scope.dialog.close()

	$scope.$apply()
]
