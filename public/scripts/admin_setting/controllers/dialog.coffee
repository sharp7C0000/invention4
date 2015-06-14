# admin new post dialog controller

define [], () -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

  # show modal on contentInvalid
	$rootScope.$on('contentInvalid', (event, message) ->
    $scope.message = message
    document.querySelector('#content-invalid').open()
  )

  $scope.submit = () ->
  	console.log "click submit"
  	$rootScope.$emit('contentInvalid', $scope.contentsErrorMessage($scope.newPostForm.contents.$error))

	$scope.$apply()
]
