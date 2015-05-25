# Load all controllers

define ["angular"], (angular) ->

  angular.module("invention4.controllers", []).controller("BlogReadPost", ["$scope", "$injector",

    # load index controller
    ($scope, $injector) ->
      require ["blog_read_post/controllers/index"], (index) ->
        $injector.invoke index, this, { $scope: $scope }
  ])
