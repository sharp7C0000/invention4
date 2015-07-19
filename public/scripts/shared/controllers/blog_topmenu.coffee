# blog topmenu controller

define ["holderjs"], () -> [ "$scope", "$http", "$sce", ($scope, $http, $sce) ->

  $scope.aboutDialog = document.querySelector('#about-dialog')
  $scope.profileData = {}

  # fetch data when open dialog
  $scope.aboutDialog.addEventListener("core-overlay-open-completed", (event) ->
    fetch()
  )

  # private
  fetch = () ->
    $http.get('/profile')
    .success((data, status, headers, config) ->
      $scope.profileData     = data.data
      # convert markdown
      $scope.profileContents = $sce.trustAsHtml($scope.profileData.contents)
    )
    .error((data, status) ->
    	# TODO: handle error
    	console.log data
    )

  $scope.clickAbout = () ->
    $scope.aboutDialog.toggle()

  $scope.$apply()
]
