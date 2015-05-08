module.exports = (app) ->
	app.controller('AppInfoCtrl', ['$state', '$scope', '$rootScope', '$location', 'AppService',
		($state, $scope, $rootScope, $location, AppService) ->
			$scope.app = {}

			AppService.get $state.params.id
				.then (app) ->
					console.log app
					$scope.app = app
					$scope.$apply()
				.fail (e) ->
					console.log e

			$scope.deleteApp = () ->
				if confirm 'Are you sure you want to delete this app?'
					AppService.delete $scope.app
						.then () ->
							$state.go 'app-list'
						.fail (e) ->
							console.log e

			$scope.resetKeys = () ->
				if confirm 'Are you sure you want to reset this app\'s keys?'
					AppService.keygen $scope.app
						.then (app) ->
							$state.go 'app-info', {
								id: app.id
							}
						.fail (e) ->
							console.log e
	])
