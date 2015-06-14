# admin index controller

define ["holderjs"], () -> [ "$scope", "$http", ($scope, $http) ->

	$scope.clickPhotoEdit = () ->
		console.log "click"
		document.querySelector('#content-invalid').open()

	$scope.$apply()
]
