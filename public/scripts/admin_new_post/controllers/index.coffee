# admin index controller

define ["shared/controllers/form"], (formCtrl) -> [ "$scope", "$http", ($scope, $http) ->

	# extend common form controller
	angular.extend(this, new formCtrl($scope, $http))
	$scope.targetForm = $scope.newPostForm

	$scope.cancel = (url) -> window.location = url

	$scope.$apply()
]