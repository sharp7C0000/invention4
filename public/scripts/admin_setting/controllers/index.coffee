# admin index controller

define ["holderjs"], () -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

	$scope.clickPhotoEdit = () ->
		console.log "click"
		$rootScope.$emit('imgDialog', $scope.formData.photoUrl)

	$scope.$apply()
]
