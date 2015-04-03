class WorkerSvc
  constructor: (@cache)->
    @workers = {}
    @URLs = {}

  getURL: (path)->
    return @URLs[path] if @URLs[path]?
    logic = @cache.get path
    blob = new Blob([logic], {type: 'text/javascript'})
    @URLs[path] = window.URL.createObjectURL(blob)

  get: (path)->
    return @workers[path] if @workers[path]?
    code = @getURL path
    @workers[path] = new Worker(code)

WorkerSvc.$inject = ['$workerCache']

angular.module('workers', [])

angular.module('eau.workers', [
  'workers'
])
.factory '$workerCache', ($cacheFactory)->
  $cacheFactory.get 'workersCache'
.service 'WorkerSvc', WorkerSvc
