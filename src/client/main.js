angular.module('eau', [
  'ngMaterial',
  'eau.head-controller',
  'eau.navigation',
  'eau.simulation',
  'eau.simulation.spring',
  'eau.simulation.nbody',
  'eau.simulation.compression',
  'eau.simulation.truss'
])
.config(function($mdThemingProvider) {
  $mdThemingProvider.theme('default')
    .primaryPalette('grey')
    // .accentPalette('blue-grey')
    // .warnPallette('amber')
    ;
})
;
