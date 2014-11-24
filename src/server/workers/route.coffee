WorkerWatcher = require './watcher'

module.exports = (app, config)->
  sw = new WorkerWatcher config.stassets
  app.use (q, s, n)->
    if sw.matches q.path
      return sw.handle(q, s, n)
    else
      n()
