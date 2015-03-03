angular.module('eau', [
  'ngMaterial',
  'eau.head-controller',
  'eau.navigation',
  'eau.simulation',
  'eau.simulation.compression',
  'eau.simulation.arch'
])
.config(function($mdThemingProvider) {
  $mdThemingProvider.theme('default')
    .primaryPalette('grey')
    // .accentPalette('blue-grey')
    // .warnPallette('amber')
    ;
})
;
