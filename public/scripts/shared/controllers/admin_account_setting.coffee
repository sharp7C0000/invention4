# admin account setting controller

define ["shared/controllers/form"], (formCtrl) -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

  $scope.dialog = document.querySelector('#admin-account-setting-dialog')

  # fetch data when open dialog
  $scope.dialog.addEventListener("core-overlay-open-completed", (event) ->
    fetch()
  )

  $rootScope.$on('accountSettingDialog', (event, message) ->
    $scope.dialog.open()
  )

  # private
  fetch = () ->
    $http.post('/admin/account/info', {userID: $scope.userID})
    .success((data, status, headers, config) ->
      console.log data, status, headers, config
      #$scope.profileData     = data.data
      # convert markdown
      #$scope.profileContents = $sce.trustAsHtml($scope.profileData.contents)
    )
    .error((data, status) ->
    	# TODO: handle error
    	console.log data
    )

  $scope.$apply()

]
