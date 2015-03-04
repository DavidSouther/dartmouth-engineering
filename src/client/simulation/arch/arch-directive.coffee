angular.module('eau.simulation.arch', [
  'eau.navigation'
  'simulation.arch.template'
])
.config ['SimulationNavProvider', (sims)->
  sims.sim 'arch',
    title: 'Arch'
]
.directive 'arch', ->
  restrict: 'E'
  templateUrl: 'simulation/arch'
  controller: ($scope)->
    $scope.simulation =
      applied: 1e2
      height: 200
      span: 200

    $scope.simulation.internal = ->
      1e2

    $scope.simulation.failure = ->
      1e6

    $scope.simulation.loadX = ->
      a = $scope.simulation.applied / 2
      h = $scope.simulation.height
      s = $scope.simulation.span
      length = Math.sqrt h * h + s * s
      force = Math.sqrt a * a
      force * h / length

    $scope.simulation.loadY = ->
      a = $scope.simulation.applied / 2
      h = $scope.simulation.height
      s = $scope.simulation.span / 2
      length = Math.sqrt h * h + s * s
      force = Math.sqrt a * a
      force * s / length
