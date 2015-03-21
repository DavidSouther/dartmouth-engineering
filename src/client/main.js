angular.module('eau', [
  'ngMaterial',
  'eau.head-controller',
  'eau.navigation',
  'eau.simulation',
  'eau.simulation.compression',
  'eau.simulation.arch',
  'eau.simulation.tension'
])
.config(function($mdThemingProvider) {
  $mdThemingProvider.theme('default')
    .primaryPalette('grey')
    .accentPalette('blue')
    // .warnPallette('amber')
    ;
})
;
