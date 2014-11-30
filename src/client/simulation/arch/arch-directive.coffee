angular.module('eau.simulation.arch', [
  'eau.navigation'
  'eau.simulation.arch.brick'
  'simulation.arch.arch-template.template'
])
.directive 'arch', ->
  restrict: 'E'
  templateUrl: 'simulation/arch/arch-template'
  scope:
    arch: '=bricks'
