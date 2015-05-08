Q = require('q')

module.exports = (app) ->
	app.factory('AppService', ['$rootScope', '$http',
		($rootScope, $http) ->
			return {
				getAll: () ->
					defer = Q.defer()
					$http {
						url: '/api/apps'
					}
						.success (response) ->
							defer.resolve(response)
						.error (e) ->
							defer.reject e
					defer.promise
				get: (id) ->
					defer = Q.defer()
					$http {
						url: '/api/apps/' + id
					}
						.success (response) ->
							defer.resolve(response)
						.error (e) ->
							defer.reject e
					defer.promise
				create: (app) ->
					defer = Q.defer()
					$http {
						url: '/api/apps',
						method: 'POST',
						data: app
					}
						.success (response) ->
							defer.resolve(response)
						.error (e) ->
							defer.reject e
					defer.promise
				update: (app) ->
					defer = Q.defer()
					$http {
						url: '/api/apps',
						method: 'PUT',
						data: app
					}
						.success (response) ->
							defer.resolve(response)
						.error (e) ->
							defer.reject e
					defer.promise
				delete: (app) ->
					defer = Q.defer()
					$http {
						url: '/api/apps/' + app.id,
						method: 'DELETE'
					}
						.success (response) ->
							defer.resolve(response)
						.error (e) ->
							defer.reject e
					defer.promise
				keygen: (app) ->
					defer = Q.defer()

					$http {
						url: '/api/apps/' + app.id + '/keygen',
						method: 'POST'
					}
						.success (response) ->
							defer.resolve response
						.error (e) ->
							defer.reject e
					defer.promise
 			}
	])
