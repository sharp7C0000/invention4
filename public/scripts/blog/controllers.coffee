# Load all controllers

define ["angular"], (angular) ->

  angular.module("invention4.controllers", [])
  .controller("BlogTopMenu", ["$scope", "$injector",
		# load blog top menu controller
		($scope, $injector) ->
			require ["shared/controllers/blog_topmenu"], (topmenu) ->
			  $injector.invoke topmenu, this, { $scope: $scope }
	])
  .controller("Blog", ["$scope", "$injector",
    # load index controller
    ($scope, $injector) ->
      require ["blog/controllers/index"], (index) ->
        $injector.invoke index, this, { $scope: $scope }
  ])
