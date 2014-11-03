# Load all controllers

define ["angular"], (angular) ->

  angular.module("invention4.controllers", []).controller("Auth", ["$scope", "$injector",
    
    # load auth controller
    ($scope, $injector) ->
      require ["auth/controllers/index"], (index) ->
        $injector.invoke index, this, { $scope: $scope }
  ])