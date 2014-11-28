angular.module('eau.simulation', [
  'eau.simulation.service'
  'simulation.simulation-template.template'
    'eau.simulation.arch'
  'graphing.scales'
  'graphing.svg'
]).directive 'simulation', ->
  restrict: 'E'
  templateUrl: 'simulation/simulation-template'
  controller: ($scope, SimulationSvc)->
    $scope.dt = 16 # 16 millisecond tick
    $scope.simulation = SimulationSvc
