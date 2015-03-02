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
      applied: 0
      height: 200
      span: 200

    $scope.simulation.internal = ->
      1e2

    $scope.simulation.failure = ->
      1e6
