module.exports = (app) ->
	app.controller('AppCreationCtrl', ['$state', '$scope', '$rootScope', '$location', 'AppService',
		($state, $scope, $rootScope, $location, AppService) ->
			$('.nav a').removeClass 'active'
			$('.nav a.app-creation').addClass 'active'
			
			$scope.app = {
				name: 'My App'
				description: 'My app description'
				redirectUri: 'http://localhost:6284/auth'
			}

			$scope.createApp = () ->
				AppService.create($scope.app)
					.then (app) ->
						$state.go 'app-info', {
							id: app.id
						}
					.fail (e) ->
						console.log e




			
	])
