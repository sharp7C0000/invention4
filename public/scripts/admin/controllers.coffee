# Load all controllers

define ["angular"], (angular) ->

  angular.module("invention4.controllers", []).controller("Admin", ["$scope", "$injector",
    
    # load auth controller
    ($scope, $injector) ->
      require ["admin/controllers/index"], (index) ->
        $injector.invoke index, this, { $scope: $scope }
  ])