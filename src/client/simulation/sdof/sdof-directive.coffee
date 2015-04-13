angular.module('eau.simulation.sdof', [
  'simulation.sdof.template'
  'eau.utilities.scientific'
  'graphing.scales'
  'graphing.svg'
  'ngMaterial'
  'eau.navigation',
  'eau.arrow'
]).config ['SimulationNavProvider', (sims)->
  sims.sim 'sdof',
    title: 'Single Degree of Freedom'
]
.directive 'sdof', ->
  restrict: 'E'
  templateUrl: 'simulation/sdof'
  controller: ($scope)->
    s = $scope.simulation =
      length: 15
      mass: 10000
      cross: 0.3

    theta = $scope.theta = Math.sqrt(3) / 2
    TO_DEG = 180 / Math.PI

    iPiHalf = 1 / (2 * Math.PI)
    $scope.frequency = ->
      k = $scope.stiffness()
      m = s.mass
      iPiHalf * Math.sqrt(k / m)

    $scope.stiffness = ->
      I = Math.pow(s.cross, 4) / 12
      E = 10e9
      L = s.length
      3 * E * I / ( L * L * L)

    $scope.tick = do ->
      angle = theta
      direction = 1
      ->
        f = $scope.frequency()
        p = direction * f
        angle += p / 30
        if Math.abs(angle) > Math.abs(theta)
          direction *= -1
        angle
