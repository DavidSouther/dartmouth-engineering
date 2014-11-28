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
    @running = no
    @worker = WorkerSvc.get('/simulation/verlet.coffee')
    # @worker.addEventListener('message', ((e)->console.log(e)))
    @worker.addEventListener('error', ((e)->console.error(e)))
    [
      '/simulation/constraints/ground.coffee'
      '/simulation/forces/gravity.coffee'
    ].forEach (path)=>
      @worker.postMessage({event: 'load', url: WorkerSvc.getURL(path)})
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
      dimensions: 2
      positions: data.buffer
    @worker.postMessage event, [data.buffer]

  tick: (dt = 16)->
    @worker.postMessage {event: 'tick', dt}

  render: ({positions})->
    if @running then requestAnimationFrame(=>@tick())
    positions = new Float64Array(positions)
    for i in [0...10]
      @positions[i * 2] = positions[i * 2]
      @positions[i * 2 + 1] = positions[i * 2 + 1]

  run: ->
    @running = yes
    @tick()

  toggle: ->
    if @running then @running = no else @run()

Simulation.$inject = [
  'WorkerSvc'
  '$rootScope'
]

angular.module('eau.simulation.service', [
  'eau.workers'
]).service 'SimulationSvc', Simulation
