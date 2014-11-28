global.root = __dirname;

var config = require('./server.json');
config.name = require('./package.json').name;
config.stassets.vendors.config.dependencies[__dirname + '/src/config'] = true;

module.exports = require('rupert')(config); // Export for use by tools

if (require.main === module) {
    module.exports.start(function(){});
}
