# admin index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	#console.log "admin new!", CodeMirror

	editor = new Editor()
	editor.render()

	$scope.addPost = (url)-> 
		console.log "AddPost"
		window.location = url

	$scope.$apply()
]