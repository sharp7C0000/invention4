# admin index controller

define ['moment'], (moment) -> [ "$scope", "$http", ($scope, $http) ->

	console.log "index!", moment

	$http.get('/admin/posts/list')
	  .then((result) ->
	    console.log result
	    $scope.posts = result.data.data.posts
	    console.log "ppp", $scope.posts
	)

	$scope.toShortDate = (data) ->
		moment(data).format("YYYY-MM-DD")

	$scope.addPost = (url)-> 
		console.log "AddPost"
		window.location = url

	$scope.$apply()
]