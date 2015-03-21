angular.module('eau.simulation.tension', [
  'simulation.tension.template'
  'eau.utilities.scientific'
  'eau.arrow'
  'graphing.scales'
  'graphing.svg'
  'ngMaterial'
])
.config ['SimulationNavProvider', (sims)->
  sims.sim 'tension',
    title: 'Funicular Tension'
]
.directive 'tension', ->
  restrict: 'E'
  templateUrl: 'simulation/tension'
  controller: ($scope, MaterialList, MomentShapes)->
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

    $scope.theta = ->
      s = $scope.simulation
      Math.atan(s.pull / (s.width / 2))

    $scope.thetaDeg = ->
      $scope.theta() * 180 / Math.PI

    $scope.simulation.stress = ->
      # Force in the cable, F = (allow_stress)*(cross‐sectional Area)
      d = $scope.simulation.diameter
      m = $scope.simulation.material

      a = Math.PI * d * d
      m.maxStress * a

    $scope.simulation.load = ->
      # Allowable Load = P = 2*F*sinθ; where θ=tan‐1(h/L)
      s = Math.sin $scope.theta()
      2 * s * $scope.simulation.stress()

    $scope.showLoad = no
