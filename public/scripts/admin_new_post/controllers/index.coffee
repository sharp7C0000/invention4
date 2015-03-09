# admin index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	console.log "admin new!"

	editor = new EpicEditor(
		basePath: '/css/epiceditor'
		button: {
	    preview: true
	    parser: "marked"
	    bar: "auto"
  	}
	).load()

	$scope.addPost = (url)-> 
		console.log "AddPost"
		window.location = url

	$scope.$apply()
]