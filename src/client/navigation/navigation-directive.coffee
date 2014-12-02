SimulationNav = ($stateProvider)->
  simlist = []

  sim: (name, args)->
    if arguments.length is 1
      args = name
    else
      args.name = name
    args.template or= "<#{args.name} />" unless args.templateUrl
    simlist.push(args)

    $stateProvider.state args.name,
      url: "/#{args.name}"
      views: "simulation": args

  $get: -> simlist

SimulationNav.$inject = ['$stateProvider']

NavigationCtrl = (@sims)->
NavigationCtrl.$inject = ['SimulationNav']

angular.module('eau.navigation', [
  'ui.router'
  'navigation.template'
])
.provider('SimulationNav', SimulationNav)
.controller('NavigationCtrl', NavigationCtrl)
.directive 'navigation', ->
  restrict: 'E'
  templateUrl: 'navigation'
  controller: 'NavigationCtrl'
  controllerAs: 'nav'
