// # Ghost Configuration
var path = require('path'),
    config;

config = {
    production: {
        url: 'https://blog.carterjones.info',
        mail: {},
        database: {
            client: 'sqlite3',
            connection: {
                filename: path.join(process.env.GHOST_CONTENT, '/data/ghost.db')
            },
            debug: false
        },

        server: {
            host: '0.0.0.0',
            port: '2368'
        },

        paths: {
            contentPath: path.join(process.env.GHOST_CONTENT, '/')
        }
    }
};

module.exports = config;
