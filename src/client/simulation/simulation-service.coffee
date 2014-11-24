class Particle
  constructor: (@simulation, @index)->
    Object.defineProperty @, 'position',
      get: ->
        [
          @simulation.positions[@index * 2],
          @simulation.positions[@index * 2 + 1]
        ]

class Simulation
  constructor: (WorkerSvc, $rootScope)->
    @worker = WorkerSvc.get('/simulation/verlet.coffee')
    # @worker.addEventListener('message', ((e)->console.log(e)))
    @worker.addEventListener('error', ((e)->console.error(e)))
    @worker.addEventListener 'message', ({data})=>
      $rootScope.$apply =>
        @[data.event]?(data)
    @particles = []
    @positions = new Float64Array(10 * 2)
    for i in [0...10]
      @particles[i] = new Particle(@, i)
    @reset()

  reset: ->
    for i in [0...@particles.length]
      @positions[i * 2] = Math.random()
      @positions[i * 2 + 1] = Math.random()
    data = new Float64Array(@positions) # Clone
    event =
      event: 'reset'
      count: data.length
      dimension: 2
      positions: data.buffer
    @worker.postMessage event, [data.buffer]

  tick: (dt = 16)->
    @worker.postMessage {event: 'tick', dt}

  render: ({positions})->
    positions = new Float64Array(positions)
    for i in [0...10]
      @positions[i * 2] = positions[i * 2]
      @positions[i * 2 + 1] = positions[i * 2 + 1]
    console.log @positions

Simulation.$inject = [
  'WorkerSvc'
  '$rootScope'
]

angular.module('eau.simulation.service', [
  'eau.workers'
]).service 'SimulationSvc', Simulation
