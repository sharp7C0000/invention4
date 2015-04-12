# admin index controller

define ["shared/controllers/form"], (formCtrl) -> [ "$scope", "$http", ($scope, $http) ->

	# extend common form controller
	angular.extend(this, new formCtrl($scope, $http))
	$scope.targetForm = $scope.newPostForm

 	# initialize editor
	editor = new Editor()
	editor.render()

	$scope.cancel = (url) -> window.location = url

	$scope.$apply()
]