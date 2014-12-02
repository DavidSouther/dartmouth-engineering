angular.module('eau.simulation.arch.brick', [
  'simulation.arch.brick.template'
])
.directive 'brick', ->
  restrict: 'E'
  replace: yes
  templateUrl: 'simulation/arch/brick'
  templateNamespace: 'svg'
  # scope:
  #   corner: '@'
