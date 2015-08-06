# admin account setting controller

define ["shared/controllers/form"], (formCtrl) -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

  submitSuccess = (data, status, headers, config) ->

  submitError = (data, status, headers, config) ->

  angular.extend(this, new formCtrl($scope, $http, submitSuccess, submitError))

  $scope.targetForm = $scope.accountSettingForm

  $scope.checkNewPasswordMathing = () ->
    newPasswordValue    = $scope.formData.newPassword
    repeatPasswordValue = $scope.formData.repeatPassword

    repeatPasswordValid = $scope.accountSettingForm.repeatPassword.$valid
    repeatPasswordError = $scope.accountSettingForm.repeatPassword.$error

    if newPasswordValue != repeatPasswordValue
      # generate custom message
      $scope.accountSettingForm.repeatPassword.$valid = false
      $scope.accountSettingForm.repeatPassword.$error = {custom: {
        message: "Password is not matching"
      }}
    else
      $scope.accountSettingForm.repeatPassword.$valid = true
      delete $scope.accountSettingForm.repeatPassword.$error["custom"]

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
      $scope.username  = data.data.username
      $scope.email     = data.data.email
    )
    .error((data, status) ->
    	# TODO: handle error
    	console.log data
    )

  $scope.$apply()

]
