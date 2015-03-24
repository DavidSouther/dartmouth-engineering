angular.module('eau.simulation.tension', [
  'simulation.tension.template'
  'eau.utilities.scientific'
  'eau.arrow'
  'graphing.scales'
  'graphing.svg'
  'ngMaterial'
  'eau.navigation'
])
.config ['SimulationNavProvider', (sims)->
  sims.sim 'tension',
    title: 'Funicular Tension'
]
.directive 'tension', ->
  restrict: 'E'
  templateUrl: 'simulation/tension'
  controller: ($scope)->
    $scope.materials = [{
      name: 'Steel'
      maxStress: 250e6
    }, {
      name: 'Nylon'
      maxStress: 50e6
    }]

    $scope.simulation =
      width: 4 # m
      pull: 2 # m
      diameter: 10 # mm
      material: $scope.materials[0]

    $scope.area = ->
      d = $scope.simulation.diameter
      d2 = d / 2
      Math.PI * d2 * d2

    $scope.theta = ->
      s = $scope.simulation
      Math.atan(s.pull / (s.width / 2))

    $scope.thetaDeg = ->
      $scope.theta() * 180 / Math.PI

    $scope.simulation.stress = ->
      # Force in the cable, F = (allow_stress)*(cross‐sectional Area)
      a = $scope.area() / 1000 # mm to m
      m = $scope.simulation.material
      m.maxStress * a

    $scope.simulation.load = ->
      # Allowable Load = P = 2*F*sinθ; where θ=tan‐1(h/L)
      s = Math.sin $scope.theta()
      2 * s * $scope.simulation.stress()

    $scope.showLoad = no
