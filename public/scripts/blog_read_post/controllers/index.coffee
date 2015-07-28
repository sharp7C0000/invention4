# Sample index controller

define ['highlightjs'], (hj) -> [ "$scope", "$http", ($scope, $http) ->

	# init markdown code highlight
	hj.initHighlighting()

	$scope.clickTitle = ($event) ->
		$event.preventDefault()

	$scope.clickShare = ($event) ->
		document.getElementById("userinfo").toggle()

	$scope.clickBack = () -> window.history.back()

	$scope.$apply()
]
