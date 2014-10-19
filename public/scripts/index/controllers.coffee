# Load all controllers

define ["angular"], (angular) ->

  angular.module("invention4.controllers", []).controller("Index", ["$scope", "$injector",
    
    # load index controller
    ($scope, $injector) ->
      require ["index/controllers/index"], (index) ->
        $injector.invoke index, this, { $scope: $scope }
  ])