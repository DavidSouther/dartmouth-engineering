PI_SQUARED = Math.PI * Math.PI
GRAVITY = 9.81

angular.module('eau.simulation.compression', [
  'simulation.compression.template'
  'graphing.scales'
  'graphing.svg'
])
.config ['SimulationNavProvider', (sims)->
  sims.sim 'compression',
    title: 'Column Compression'
]
.directive 'compression', ->
  restrict: 'E'
  templateUrl: 'simulation/compression'
  controller: ($scope, SimulationFactory)->
    s = $scope.simulation =
      length: 32.2
      tiparea: 2 * 2
      basearea: 8 * 8
      elasticity: '10e9'
      density: 0.27
    $scope.simulation.buckle = ->
      ba = parseFloat(s.basearea)
      l = parseFloat(s.length)
      e = parseFloat(s.elasticity)
      moment = (ba * ba) / 12
      l2 = l * l
      buckle = PI_SQUARED * e * moment / l2
      buckle
    $scope.simulation.applied = ->
      ba = parseFloat(s.basearea)
      ta = parseFloat(s.tiparea)
      l = parseFloat(s.length)
      volume = l * (ba + ta) / 2
      parseFloat(s.density) * volume * GRAVITY
