angular.module('eau.simulation.arch', [
  'eau.navigation'
  'eau.simulation.arch.brick'
  'simulation.arch.template'
])
.directive 'arch', ->
  restrict: 'E'
  templateUrl: 'simulation/arch'
  scope:
    arch: '=bricks'
