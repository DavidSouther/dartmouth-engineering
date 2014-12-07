module.exports = (grunt)->
  require('rupert-grunt')(grunt, {
    server: __dirname + '/app.js',
    client: write:
      files: ['workers.js']
      dest: 'simulations'
  })

  grunt.registerTask 'watcher', [ 'rupert-watch' ]
  grunt.registerTask 'default', [ 'rupert-default' ]
