angular.module('eau.simulation.arch.brick', [
  'simulation.arch.brick.brick-template.template'
])
.directive 'brick', ->
  restrict: 'E'
  replace: yes
  templateUrl: 'simulation/arch/brick/brick-template'
  templateNamespace: 'svg'
  # scope:
  #   corner: '@'
