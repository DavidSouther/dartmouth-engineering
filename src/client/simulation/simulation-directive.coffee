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
    $scope.simulation = SimulationSvc
