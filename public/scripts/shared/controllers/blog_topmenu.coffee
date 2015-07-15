# blog topmenu controller

define [], () -> [ "$scope", "$http", ($scope, $http) ->
  $scope.aboutDialog = document.querySelector('#about-dialog')

  $scope.clickAbout = () ->
    $scope.aboutDialog.toggle()

  $scope.$apply()
]
