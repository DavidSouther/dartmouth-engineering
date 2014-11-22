class WorkerSvc
  constructor: (@cache)->
    @workers = {}

  get: (path)->
    return @workers[path] if @workers[path]?
    logic = @cache.get path
    blob = new Blob([logic], {type: 'text/javascript'})
    URL = window.URL || window.webkitURL
    code = URL.createObjectURL(blob)
    @workers[path] = new Worker(code)

WorkerSvc.$inject = ['$workerCache']

angular.module('eau.workers', [
  'workers'
])
.factory '$workerCache', ($cacheFactory)->
  $cacheFactory.get 'workersCache'
.service 'WorkerSvc', WorkerSvc
