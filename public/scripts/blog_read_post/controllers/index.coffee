# Sample index controller

define ['highlightjs'], (hj) -> [ "$scope", "$http", ($scope, $http) ->

	# init markdown code highlight
	hj.initHighlighting()

	# init social icon
	soc.render()

	$scope.clickTitle = ($event) ->
		$event.preventDefault()

	$scope.clickShare = ($event) ->
		document.getElementById("social-share").toggle()

	$scope.clickBack = () -> window.history.back()

	$scope.$apply()
]
