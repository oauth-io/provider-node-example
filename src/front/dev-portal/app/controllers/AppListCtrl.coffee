module.exports = (app) ->
	app.controller('AppListCtrl', ['$state', '$scope', '$rootScope', '$location', 'AppService',
		($state, $scope, $rootScope, $location, AppService) ->
			$('.nav a').removeClass 'active'
			$('.nav a.app-list').addClass 'active'

			$scope.apps = []
			
			AppService.getAll()
				.then (apps) ->
					$scope.apps = apps
					$scope.$apply()
				.fail (e) ->
					console.log e


			
	])
