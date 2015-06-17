# admin new post dialog controller

define [], () -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

  # show modal on contentInvalid
	$rootScope.$on('imgDialog', (event, message) ->
    $scope.message = message
    document.querySelector('#profile-photo-dialog').open()
  )

	$scope.submit = () ->
		console.log "click submit"
		$rootScope.$emit('contentInvalid')

	$scope.$apply()
]
