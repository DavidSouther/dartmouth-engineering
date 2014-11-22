angular.module('eau.simulation', [
  'eau.simulation.service'
  'simulation.simulation-template.template'
]).directive 'simulation', ->
  restrict: 'E'
  templateUrl: 'simulation/simulation-template'
  controller: ($scope, SimulationSvc)->
    $scope.sim = SimulationSvc
