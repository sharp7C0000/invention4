# admin index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	console.log "index!"

	$scope.addPost = (url)-> 
		console.log "AddPost"
		window.location = url

	$scope.$apply()
]