angular.module('eau.simulation.spring', [
  'eau.simulation.service'
  'simulation.simulation-template.template'
  'eau.simulation.arch'
  'graphing.scales'
  'graphing.svg'
])
.config ['SimulationNavProvider', (sims)->
  sims.sim 'spring',
    title: 'Brick on a Spring'
]
.directive 'spring', ->
  restrict: 'E'
  templateUrl: 'simulation/simulation-template'
  controller: ($scope, SimulationFactory)->
    $scope.simulation = SimulationFactory.build 2,
      [
        '/simulation/spring/spring.coffee'
      ],
      ->
        for i in [0...@N]
          @positions[i * 2] = Math.random()
          @positions[i * 2 + 1] = Math.random()
        springList = {}
        event =
          event: 'setSprings'
        @worker.postMessage event
