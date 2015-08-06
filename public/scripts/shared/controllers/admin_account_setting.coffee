# admin account setting controller

define ["shared/controllers/form"], (formCtrl) -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

  submitSuccess = (data, status, headers, config) ->
    $scope.saveSuccess = true

  submitError = (data, status, headers, config) ->
    if data.error?
      error = data.error
      # handling database error
      if error.type == "DATABASE_ERROR"
        $scope.formData.valid.global = true
        $scope.formData.error.global = "Database error occured"

  angular.extend(this, new formCtrl($scope, $http, submitSuccess, submitError))

  $scope.targetForm  = $scope.accountSettingForm
  formDataOri = angular.copy($scope.formData)

  $scope.submitForm = (url) ->
    $scope.saveSuccess = false
    $scope.submit(url)

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

  $scope.dialog.addEventListener("core-overlay-open", (event) -> init())

  # fetch data when open dialog
  $scope.dialog.addEventListener("core-overlay-open-completed", (event) -> fetch())

  $rootScope.$on('accountSettingDialog', (event, message) -> $scope.dialog.open())

  # private
  init = () ->
    $scope.formData   = angular.copy(formDataOri)
    $scope.targetForm.$setPristine()

    $scope.username    = ""
    $scope.email       = ""
    $scope.saveSuccess = false

    $scope.formData.repeatPassword = null
    $scope.formData.oldPassword = null
    $scope.formData.newPassword = null

    # polymer ui bug
    # manal focus input
    $decorators = document.getElementsByName("paper-input-decorator")
    angular.forEach $decorators, (v, k) -> v.focused = true
    setTimeout((() ->
      angular.forEach $decorators,(v, k) -> v.focused = false
    ), 100)

  fetch = () ->
    $http.post('/admin/account/info')
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
