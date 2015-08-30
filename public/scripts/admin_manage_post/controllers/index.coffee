# admin index controller

define ['moment'], (moment) -> [ "$scope", "$http", ($scope, $http) ->

	# initialize form data
	$scope.formData = []

	fetch = () ->
		$http.get('/admin/posts/list')
	  .success((data, status, headers, config) ->
	  	# reset check all checkbox
	  	document.getElementsByName("check-all")[0].checked = false
	  	$scope.posts = data.data.posts
		)
		.error((data, status) ->
			# TODO: handle error
			console.log data
		)

	updateBulk = () ->
		$scope.formData = []
		bulkButton      = document.getElementById("remove-posts")
		checks          = document.getElementsByName("check")
		checkAll        = document.getElementsByName("check-all")[0]
		length          = 0

		angular.forEach(checks, (v, k) ->
			if v.checked == true
				$scope.formData.push(v.getAttribute("id"))
				length = length + 1
		)

		# detect check all state
		checkAll.checked = if length == checks.length then true else false

		if length > 0
			bulkButton.style.display = ''
		else
			bulkButton.style.display = 'none'

	$scope.editPost = (editUrl, postId) ->
		window.location = editUrl + postId

	$scope.removePost = (deleteUrl, postId) ->
		# TODO : confirm remove
		$http.delete(deleteUrl + postId)
		.success((data, status, headers, config) -> fetch())
		.error((data, status) ->
			# TODO: handle error
			console.log data
		)

	$scope.removePosts = (deleteUrl) ->
		# TODO : confirm remove
		$http.post(deleteUrl, $scope.formData)
		.success((data, status, headers, config) -> fetch())
		.error((data, status) ->
			# TODO: handle error
			console.log data
		)

	$scope.toShortDate = (dateData) -> moment(dateData).format("YYYY-MM-DD")

	$scope.addPost = (url)-> window.location = url

	# attach paper-checkbox event
	document.getElementsByName("check-all")[0].addEventListener("change", (event) ->
		checked = event.target.checked
		angular.forEach(document.getElementsByName("check"), (v, k) -> v.checked = checked)
		updateBulk()
	)

	document.addEventListener("change", (event) ->
		updateBulk() if event.target.getAttribute("name") == "check"
	)

	# fetch first document
	fetch()

	$scope.$apply()
]
