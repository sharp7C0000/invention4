# admin new post dialog controller

define [], () -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

	$scope.formData = {}

  # show photo url modal
	$rootScope.$on('imgDialog', (event, message) ->
    document.querySelector('#profile-photo-dialog').open()
  )

	$scope.submit = () ->
		$rootScope.$emit('updateProfileImage', $scope.formData.photoUrl)

	$scope.$apply()
]
