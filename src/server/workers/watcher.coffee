Q = require 'q'
ScriptWatcher = require 'rupert/node_modules/stassets/lib/Watchers/Script'

class WorkerWatcher extends ScriptWatcher
  constructor: (@config)->
    super(@config)

  getPaths: -> ['/workers.js']

  pattern: ->
    types = Object.keys(ScriptWatcher.renderers)
    patterns = ["**/*.{#{types.join(',')}}.worker"]
    rootPatterns = (pattern)=>
      @config.root.map (root)->
        "#{root}/#{pattern}"
    flatten = (a, v)->a.concat(v)
    fullList = patterns.map(rootPatterns).reduce(flatten, [])
    fullList

  patternOrder: (path)-> 0

  render: (code, path)->
    compiled = super(code, path.replace('.worker', ''))

  concat: (_)->
    content =
      "angular.module('workers', [])" +
      ".run(function($cacheFactory){\n" +
      "var cache = $cacheFactory('workersCache');\n"

    _.forEach (file)=>
      shortPath = @pathpart file.path
      escapeContent = file.content
        .replace(/\\/g, '\\\\')
        .replace(/'/g, '\\\'')
        .replace(/\r?\n/g, '\\n')
      content += "cache.put('#{shortPath}', '#{escapeContent}');\n"

    content += "});\n"

    Q {content, sourceMap: null}

module.exports = WorkerWatcher
