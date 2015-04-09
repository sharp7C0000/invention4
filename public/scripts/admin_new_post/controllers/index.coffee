# admin index controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->

	editor = new Editor()
	editor.render()

	$scope.cancel = (url) -> window.location = url

	$scope.submit = (url) ->
		form = $scope.newPostForm
		console.log form


	$scope.$apply()
]