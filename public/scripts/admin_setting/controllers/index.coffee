# admin index controller

define ["holderjs"], () -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

	$scope.formData = {}

	# update profile photo
	$rootScope.$on('updateProfilePhoto', (event, message) ->
    $scope.formData.profilePhotoUrl = message
  )

	$scope.clickPhotoEdit = () ->
		$rootScope.$emit('profilePhotoDialog', $scope.formData.profilePhotoUrl)

	$scope.$apply()
]
