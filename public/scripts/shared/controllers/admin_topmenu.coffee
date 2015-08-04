# admin and login topmenu controller

define [], () -> [ "$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

	$scope.home = () -> window.location = "/"

	$scope.tab  = (url) -> window.location = url

	$scope.clickAccountSetting = () -> $rootScope.$emit('accountSettingDialog')

	$scope.logout = (url) ->
		# submit server
		$http.delete(url)
		.success((data, status, headers, config) ->
			window.location = data.data.redirectUrl
		)
		.error((data, status) ->
			console.log "error", data, status
			# TODO
			# toasting error message
		)

	$scope.$apply()
]
