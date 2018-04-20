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
$ docker run -it --rm <image_name>
```

# Step-by-step Install

Install dependencies using `npm`
--------------------------------

```sh
$ npm install
```

Configure your OAuth.io API Keys
--------------------------------

Add your API keys in `config.js` to link this provider to your OAuth.io account


Compile and run
---------------

```
$ grunt && node app.js
```
