# Sample index controller

define [], () -> [ "$scope", "$http", "$window", ($scope, $http, $window) ->

	$scope.summaryOri = 	angular.copy($scope.summary)

	angular.element($window).bind('resize', () ->

		# change summary text length
		angular.forEach($scope.summaryOri, (value, key) ->

			if $window.innerWidth < 480
				$scope.summary[key] = value.substring(0, 60)

			else if $window.innerWidth < 630
				$scope.summary[key] = value.substring(0, 120)

			else
				$scope.summary[key] = value
		)

		$scope.$apply()
	)

	$scope.clickPagenator = (url) ->
		window.location = url

	$scope.$apply()


]
