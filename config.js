var config = {
	oauthd_url: 'https://oauth.io',
	debug: true,
	port: 3000,
	provider_credentials: {
		key: '',
		secret: ''
	}

};
try {
	var config_local = require('./config.local');

	for (var k in config_local) {
		config[k] = config_local[k];
	}

} catch (e) {
	console.log('No local config');
}


module.exports = config;
