FROM node:wheezy

RUN apt-get update
RUN apt-get install -y vim

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

# use changes to package.json to force Docker not to use the cache
# when we change our application's nodejs dependencies:
COPY package.json /tmp/package.json
RUN cd /tmp && npm install
RUN cp -a /tmp/node_modules /usr/src/app/

RUN npm install -g grunt-cli
RUN npm install 
RUN grunt
CMD ["/usr/local/bin/node","app.js"]
