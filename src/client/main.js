angular.module('eau', [
  'ngMaterial',
  'eau.head-controller',
  'eau.navigation',
  'eau.simulation',
  'eau.simulation.compression',
  'eau.simulation.arch',
  'eau.simulation.tension',
  'eau.simulation.truss',
  'eau.simulation.beam',
  'eau.simulation.sdof'
])
.config(function($mdThemingProvider) {
  $mdThemingProvider.theme('default')
    .primaryPalette('grey')
    .accentPalette('blue')
    // .warnPallette('amber')
    ;
})
;
