# Load all controllers

define ["angular"], (angular) ->

  angular.module("invention4.controllers", []).controller("Blog", ["$scope", "$injector",
    
    # load index controller
    ($scope, $injector) ->
      require ["blog/controllers/index"], (index) ->
        $injector.invoke index, this, { $scope: $scope }
  ])