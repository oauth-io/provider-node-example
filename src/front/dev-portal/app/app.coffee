


app = angular.module("dev-portal", ["ui.router"]).config(["$stateProvider", "$urlRouterProvider", "$locationProvider",
	($stateProvider, $urlRouterProvider, $locationProvider) ->
		$stateProvider.state 'app-creation',
			url: '/apps/new',
			templateUrl: '/templates/app-creation.html'
			controller: 'AppCreationCtrl'

		$stateProvider.state 'app-list',
			url: '/apps',
			templateUrl: '/templates/app-list.html'
			controller: 'AppListCtrl'

		$stateProvider.state 'app-edition',
			url: '/apps/:id/edit',
			templateUrl: '/templates/app-edition.html'
			controller: 'AppEditionCtrl'
		
		$stateProvider.state 'app-info',
			url: '/apps/:id',
			templateUrl: '/templates/app-info.html'
			controller: 'AppInfoCtrl'

		

		$urlRouterProvider.when "", "/apps"
		$urlRouterProvider.when "/", "/apps"

		$locationProvider.html5Mode(true)
])

require('./services/AppService') app

require('./controllers/AppCreationCtrl') app
require('./controllers/AppListCtrl') app
require('./controllers/AppInfoCtrl') app
require('./controllers/AppEditionCtrl') app


app.run(["$rootScope",
	($rootScope) ->
		return
])