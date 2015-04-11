angular.module('eau.simulation.beam', [
  'simulation.beam.template'
  'eau.utilities.scientific'
  'graphing.scales'
  'graphing.svg'
  'ngMaterial'
  'eau.navigation',
  'eau.arrow'
]).config ['SimulationNavProvider', (sims)->
  sims.sim 'beam',
    title: 'Beam'
]
.directive 'beam', ->
  restrict: 'E'
  templateUrl: 'simulation/beam'
  controller: ($scope)->
    s = $scope.simulation =
      length: 10
      support: 8
      force:
        applied: 10
        point: 5
        loading: 'point'

    $scope.$watch 'simulation.length', (nv, ov)->
      ratio = s.support / ov
      s.support = nv * ratio
      ratio = s.force.point / ov
      s.force.point = nv * ratio
      return
