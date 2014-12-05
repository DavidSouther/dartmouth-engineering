class Particle
  constructor: (@simulation, @index)->
    Object.defineProperty @, 'position',
      get: ->
        [
          @simulation.positions[@index * 2],
          @simulation.positions[@index * 2 + 1]
        ]

SimulationFactory = (WorkerSvc, $rootScope, $log)->
  class Simulation
    constructor: (@N, @scripts, @generator)->
      @dt = 16
      @running = no
      @worker = WorkerSvc.get('/simulation/verlet.coffee')
      @worker.addEventListener('error', ((e)->$log.error(e)))
      @worker.addEventListener 'message', ({data})=>@[data.event]?(data)
      @positions = new Float64Array(@N * 2)
      @particles = (new Particle(@, i) for i in [0...@N])
      @reset()
      scripts.forEach (path)=>
        @worker.postMessage({event: 'load', url: WorkerSvc.getURL(path)})

    reset: ->
      @generator.call(@)
      data = new Float64Array(@positions) # Clone
      event =
        event: 'reset'
        count: data.length
        dimensions: 2
        positions: data.buffer
      @worker.postMessage event, [data.buffer]

    tick: ->
      @worker.postMessage {event: 'tick', @dt}

    render: ({positions})->
      positions = new Float64Array(positions)
      requestAnimationFrame =>
        if @running then @tick()
        $rootScope.$apply =>
          for i in [0...@N]
            @positions[i * 2] = positions[i * 2]
            @positions[i * 2 + 1] = positions[i * 2 + 1]

    run: ->
      @running = yes
      @tick()

    toggle: ->
      if @running then @running = no else @run()

  build: (a, b, c)-> new Simulation(a, b, c)

SimulationFactory.$inject = [
  'WorkerSvc'
  '$rootScope'
  '$log'
]

angular.module('eau.simulation.service', [
  'eau.workers'
]).factory 'SimulationFactory', SimulationFactory
