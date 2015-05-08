module.exports = (app) ->
	app.controller('AppEditionCtrl', ['$state', '$scope', '$rootScope', '$location', 'AppService',
		($state, $scope, $rootScope, $location, AppService) ->
			$scope.app = {}

			AppService.get $state.params.id
				.then (app) ->
					$scope.app = app
					$scope.$apply()
				.fail (e) ->
					console.log e

			$scope.updateApp = () ->
				AppService.update($scope.app)
					.then (app) ->
						$state.go 'app-info', {
							id: app.id
						}
					.fail (e) ->
						console.log e




			
	])