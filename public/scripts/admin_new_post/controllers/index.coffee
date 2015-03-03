# admin index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	console.log "admin new!"

	editor = new EpicEditor().load()

	$scope.addPost = (url)-> 
		console.log "AddPost"
		window.location = url

	$scope.$apply()
]