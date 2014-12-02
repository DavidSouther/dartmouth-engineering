angular.module('eau.simulation.nbody', [
  'eau.simulation.service'
  'simulation.template'
  'eau.simulation.arch'
  'graphing.scales'
  'graphing.svg'
])
.config ['SimulationNavProvider', (sims)->
  sims.sim 'nbody',
    title: 'N-Body Gravity + Collisions'
]
.directive 'nbody', ->
  restrict: 'E'
  templateUrl: 'simulation'
  controller: ($scope, SimulationFactory)->
    $scope.simulation = SimulationFactory.build 20,
      [
        '/simulation/nbody/nbody.coffee'
      ],
      ->
        for i in [0...@N]
          @positions[i * 2] = Math.random()
          @positions[i * 2 + 1] = Math.random()
