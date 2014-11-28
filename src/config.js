var Path = require('path');

module.exports = function (config){

    config.vendors.js.push("graphing/www/application.js");
    config.vendors.js.push("graphing/www/templates.js");

    return config;
};
