# admin index controller

define ["holderjs"], () -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

	$scope.formData = {}

	# update profile photo
	$rootScope.$on('updateProfileImage', (event, message) ->
    console.log "message", message
    $scope.formData.photoUrl = message
  )

	$scope.clickPhotoEdit = () ->
		$rootScope.$emit('imgDialog', $scope.formData.photoUrl)

	$scope.$apply()
]
