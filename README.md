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
