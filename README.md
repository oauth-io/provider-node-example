OAuth provider example using the OAuth.io Server API with the Node.js SDK
=====================

Clone the repository:
---------------------

```sh
$ git clone https://github.com/oauth-io/oauth-provider-sample
```

EITHER:

* Use 'docker', which is a single step
* Or follow the multi-steps after

# Docker

```
# image_name is of format <your_id>/<image description name>:<version>
$ docker build . -t <image_name>
# NOTE:
# local port is the port the server will be available on the docker host
# 3000 is the default port the provider-node-example server is running
# in docker container
$ docker run -it --rm -p <local port>:3000 <image_name>
```

# Step-by-step Install

Install dependencies using `npm`
--------------------------------

```sh
$ npm install
```

Configure your OAuth.io API Keys
--------------------------------

Get your OAuth Server API key/secret from https://oauth.io under 'Platform Settings'.
Add these into `config.local.js` to link this provider to your OAuth.io account.

```
var config = {
        provider_credentials: {
                key: 'OAUTHIO PROVIDER KEY',
                secret: 'OAUTHIO PROVIDER SECRET'
        }

};
module.exports = config;
```


Compile and run
---------------

```
$ grunt && node app.js
```

The full flow to setup OAuth Server with provider-node-example and link with OAuth.io
-------------------------------------------------------------------------------------

1. Download provider-node-example & setup ngrok (get publicly accessible domain name)
# Terminal
* git clone https://github.com/oauth-io/provider-node-example
* cd provider-node-example
* ngrok http 8081
 
2. Configure OAuth Server on OAuth.io to get OAuth.io provisioned key/secret
# OAuth.io
* Configure OAuth server on OAuth.io under 'Platform Settings'
* Copy the key/secret provided by OAuth.io for your OAuth server to your OAuth server configuration

3. Use OAuth.io provisioned key/secret to complete build of OAuth Server
# Terminal
* cat README.md
* Copy the sample config.local.js
* vi config.local.js
* docker build . -t nethsix/provider-node-example:0.0.3
* docker run -it --rm -p 8081:3000 nethsix/provider-node-example:0.0.3
  * Should see:
     * `Server listening at http://localhost:3000`
* vi cat src/back/data.coffee

4. As a service that wants to use OAuth Server as OAuth provider, add as provider
# OAuth.io
* Goto 'Integrated APIs'
* Click 'Add Provider'
* Select the provider your added
* Click 'Auto-Configure'
* Click 'Save'
* Click 'Try Auth'
  * NOTE: There is no user signup process. We need to use users hard coded in provider-example-node code:
    * src/back/data.coffee
* Use the user credentials
