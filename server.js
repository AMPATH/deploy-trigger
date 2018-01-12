'use strict';

const Hapi = require('hapi');
const util = require('util'),
    spawn = require('child_process').spawn;

// Create a server with a host and port
const server = new Hapi.Server();
server.connection({
    host: '0.0.0.0',
    port: 8000
});

// Add the route
server.route({
    method: 'GET',
    path: '/deploy-test',
    handler: function (request, reply) {

        try {
            console.log(new Date()+ ' Deploying build...');
            let deploy = spawn('sh', ['/usr/local/bin/deploy-scripts/deploy.sh']);

            deploy.stdout.on('data', function (data) {    // register one or more handlers
                console.log('stdout: ' + data);
            });

            deploy.stderr.on('data', function (data) {
                console.log('stderr: ' + data);
            });

            deploy.on('exit', function (code) {
                console.log('child process exited with code ' + code);
            });
            reply('ok');

        } catch (error) {
            console.error('An error occured', error);
        }

    }
});

// Start the server
server.start((err) => {

    if (err) {
        throw err;
    }
    console.log('Server running at:', server.info.uri);
});
