# Sample index controller

define ['highlightjs'], (hj) -> [ "$scope", "$http", ($scope, $http) ->

	# init markdown code highlight
	hj.initHighlighting()

	$scope.clickTitle = ($event) ->
		$event.preventDefault()

	$scope.clickBack = () -> window.history.back()

	$scope.$apply()
]
