angular.module('eau.simulation', [
  'eau.simulation.service'
  'simulation.template'
  'eau.simulation.arch'
  'graphing.scales'
  'graphing.svg'
])
.config ['SimulationNavProvider', (sims)->
  sims.sim 'falling',
    title: 'Falling'
]
.directive 'falling', ->
  restrict: 'E'
  templateUrl: 'simulation'
  controller: ($scope, SimulationFactory)->
    $scope.simulation = SimulationFactory.build 10,
      [
        '/simulation/constraints/ground.coffee'
        '/simulation/forces/gravity.coffee'
        '/simulation/forces/bounce.coffee'
      ],
      ->
        for i in [0...@N]
          @positions[i * 2] = Math.random()
          @positions[i * 2 + 1] = Math.random()
