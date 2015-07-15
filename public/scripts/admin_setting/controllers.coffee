# Load all controllers

define ["angular"], (angular) ->

  angular.module("invention4.controllers", [])
  .controller("AdminTopMenu", ["$scope", "$injector",
		# load admin top menu controller
		($scope, $injector) ->
			require ["shared/controllers/admin_topmenu"], (topmenu) ->
				$injector.invoke topmenu, this, { $scope: $scope }
	])
  .controller("AdminSetting", ["$scope", "$injector",
    # load admin controller
    ($scope, $injector) ->
      require ["admin_setting/controllers/index"], (index) ->
        $injector.invoke index, this, { $scope: $scope }
  ])
  .controller("AdminSettingDialog", ["$scope", "$injector",
    # load admin controller
    ($scope, $injector) ->
      require ["admin_setting/controllers/dialog"], (dialog) ->
        $injector.invoke dialog, this, { $scope: $scope }
  ])
