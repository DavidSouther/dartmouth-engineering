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
      load:
        applied: 10
        point: 5
        loading: 'even'

    $scope.$watch 'simulation.length', (nv, ov)->
      if nv < 1
        s.length = nv = 1.0
      ratio = s.support / ov
      s.support = nv * ratio
      ratio = s.load.point / ov
      s.load.point = nv * ratio
      return

    $scope.$watch 'simulation.support', (v)->
      if v > s.length
        s.support = s.length

    $scope.$watch 'simulation.load.point', (v)->
      if v > s.length
        s.load.point = s.length

    $scope.forall = (n)->
      [0..Math.ceil(n)]

    $scope.V = (n)->
      w = s.length
      l = s.support
      a = s.length - s.support
      switch n
        when 1
          (w / 2 * l) * (l * l - a * a)
        when 2
          w * a
        when 3
          (w / 2 * l) * (l * l + a * a)
