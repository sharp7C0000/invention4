# Load all controllers

define ["angular"], (angular) ->

  angular.module("invention4.controllers", [])
  .controller("AdminTopMenu", ["$scope", "$injector",
		# load admin top menu controller
		($scope, $injector) ->
			require ["shared/controllers/admin_topmenu"], (topmenu) ->
				$injector.invoke topmenu, this, { $scope: $scope }
	])
  .controller("AdminAccountSettingDialog", ["$scope", "$injector",
		# load admin account setting controller
		($scope, $injector) ->
			require ["shared/controllers/admin_account_setting"], (topmenu) ->
				$injector.invoke topmenu, this, { $scope: $scope }
	])
  .controller("AdminNewPost", ["$scope", "$injector",
    # load admin new post controller
    ($scope, $injector) ->
      require ["admin_new_post/controllers/index"], (index) ->
        $injector.invoke index, this, { $scope: $scope }
  ])
  .controller("AdminNewPostDialog", ["$scope", "$injector",
    # load admin new post controller
    ($scope, $injector) ->
      require ["admin_new_post/controllers/dialog"], (index) ->
        $injector.invoke index, this, { $scope: $scope }
  ])
