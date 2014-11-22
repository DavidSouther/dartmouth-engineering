class Simulation
  constructor: (WorkerSvc)->
    @worker = WorkerSvc.get('/simulation/simulation.coffee')
    @worker.addEventListener('message', ((e)->console.log(e)))
    @worker.addEventListener('error', ((e)->console.error(e)))

  post: (msg)->
    @worker.postMessage msg

Simulation.$inject = [
  'WorkerSvc'
]

angular.module('eau.simulation.service', [
  'eau.workers'
]).service 'SimulationSvc', Simulation
