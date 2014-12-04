module.exports = function (config){

    config.vendors.js.push('flaming-sansa/www/vendors.js');
    config.vendors.js.push('flaming-sansa/www/application.js');
    config.vendors.js.push('flaming-sansa/www/templates.js');
    config.vendors.css.push('flaming-sansa/www/all.css');

    return config;
};
