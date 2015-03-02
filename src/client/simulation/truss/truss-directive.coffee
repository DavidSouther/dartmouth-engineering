angular.module('eau.simulation.truss', [
  'eau.simulation.truss.shapes'
  'simulation.truss.template'
  'eau.utilities.scientific'
  'graphing.scales'
  'graphing.svg'
  'ngMaterial'
]).config ['SimulationNavProvider', (sims)->
  sims.sim 'truss',
    title: 'Truss'
]
.directive 'truss', ->
  restrict: 'E'
  templateUrl: 'simulation/truss'
  controller: ($scope, Trusses, $mdDialog)->
    $scope.truss = Trusses.Howe.flat($scope.beams)
