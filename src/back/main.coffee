express = require "express"
bodyParser = require "body-parser"
cookieParser = require "cookie-parser"
session = require "express-session"

qs = require 'querystring'
Path = require 'path'
request = require 'request'
crypto = require 'crypto'
fs = require 'fs'

users_nonce = {}

data = require './data'
ejs = require 'ejs'


module.exports = (env) ->

	env.config = require(env.app_dir + '/config')

	provider_url = 'http://localhost:' + env.config.port
	OAuthProvider = require('oauthio-server')
	OAuthProvider.initialize(process.argv[2] || env.config?.provider_credentials?.key, process.argv[3] || env.config?.provider_credentials?.secret, {
		debug: env.config.debug,
		oauthd_url: env.config.oauthd_url
	})

	app = express()

	app.use(cookieParser())
	app.use(session({ secret: 'oauth20-provider-test-server', resave: false, saveUninitialized: false }))
	app.use(bodyParser.urlencoded({extended: false}))
	app.use(bodyParser.json())
	app.use(express.static(Path.join(__dirname + '/../front/dev-portal')))

	login_path = Path.join(__dirname + '/../front/login.html')


	app.get '/', (req,res,next) ->
		res.status(200).send('Hello world')

	app.get '/login', (req, res, next) ->
		res.sendFile login_path

	app.post '/login', (req, res, next) ->
		backUrl = req.query.backUrl || '/apps'
		if req.body.username and req.body.password
			for v in data.users
				if v.username == req.body.username and v.password == req.body.password
					req.session.user = v
					if qs.stringify(req.query) != ''
						backUrl = backUrl + '?' + qs.stringify(req.query)
					res.redirect backUrl
					break;
			if not req.session.user?
				res.status(403).send('Wrong username or password')
		else
			res.status(400).send('Missing parameters')

	isLoggedIn = (req, res, next) ->
		if req.session.user?
			next()
		else
			req.query.backUrl = req.path
			res.redirect '/login?' + qs.stringify(req.query)

	OAuthProvider.OAuth2.getUserId = (req) ->
		return req.session.user.id

	app.get '/authorize', isLoggedIn, (req, res, next) ->
		req.template = Path.join(__dirname + '/../front/decision.html')
		req.data = {
			user: req.session.user
		}
		next()
	, OAuthProvider.OAuth2.getauthorize()

	app.post '/authorize', OAuthProvider.OAuth2.postauthorize()
	app.post '/token', OAuthProvider.OAuth2.token()

	app.get '/me', OAuthProvider.OAuth2.check({scope: []}), (req, res, next) ->
		user = undefined
		for v in data.users
			if v.id == req.OAuth2.userId
				user = {}
				for kk,vv of v
					user[kk] = vv
		if user?
			delete user.password
			res.status(200).json(user)
		else
			res.status(404).send('User not found')


	# client management

	app.post '/api/apps', (req, res, next) ->
		req.body.user_id = 'someUser'
		OAuthProvider.clients.create req.body
			.then (data) ->
				res.status(200).send(data)
			.fail () ->
				res.status(500).send('An error occured')

	app.post '/api/apps/:id/keygen', (req, res, next) ->
		OAuthProvider.clients.regenerateKeys(req.params.id)
			.then (data) ->
				res.status(200).send(data)
			.fail () ->
				res.status(500).send 'An error occured'

	app.put '/api/apps', (req, res, next) ->
		OAuthProvider.clients.update req.body
			.then (data) ->
				res.status(200).send(data)
			.fail (e) ->
				console.log e
				res.status(500).send 'An error occured'

	app.get '/api/apps', (req, res, next) ->
		OAuthProvider.clients.getAll 'someUser'
			.then (data) ->
				res.status(200).send(data)
			.fail () ->
				res.status(500).send 'An error occured'

	app.get '/api/apps/:id', (req, res, next) ->
		OAuthProvider.clients.get req.params.id
			.then (data) ->
				res.status(200).send(data)
			.fail (e) ->
				console.log 'THE ERROR', e
				res.status(500).send 'An error occured'

	app.delete '/api/apps/:id', (req, res, next) ->
		OAuthProvider.clients.delete req.params.id
			.then (data) ->
				res.status(200).send(data)
			.fail () ->
				res.status(500).send 'An error occured'

	app.get /.*/, (req,res,next) ->
		res.sendFile(Path.join(__dirname + '/../front/dev-portal/index.html'))

	server = app.listen env.config.port, () ->
		host = server.address().host
		port = server.address().port

		console.log 'Server listening at http://localhost:' + port
