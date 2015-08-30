# login index controller

define ["shared/controllers/form"], (formCtrl) -> [ "$scope", "$http", ($scope, $http) ->

	submitSuccess = () -> window.location = "/admin"

	# extend common form controller
	angular.extend(this, new formCtrl($scope, $http, submitSuccess))

	$scope.targetForm = $scope.loginForm

	$scope.$apply()
]
