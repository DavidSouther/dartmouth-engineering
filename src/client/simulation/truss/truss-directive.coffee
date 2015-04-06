angular.module('eau.simulation.truss', [
  'eau.simulation.truss.shapes'
  'eau.simulation.compression.materials',
  'simulation.truss.template'
  'eau.utilities.scientific'
  'graphing.scales'
  'graphing.svg'
  'ngMaterial'
]).config ['SimulationNavProvider', (sims)->
  sims.sim 'truss',
    title: 'Truss'
]
.directive 'truss', ->
  restrict: 'E'
  templateUrl: 'simulation/truss'
  controller: ($scope, Trusses, MaterialList, $mdDialog)->
    $scope.ex =
      load:
        min: 100
        max: 100000

    $scope.loading = [
      'Center',
      'Left',
      'Even'
    ]
    s = $scope.simulation =
      height: 10 # 2 - 50
      span: 100 # 20 - 400
      load: $scope.loading[0]
      form: 'Pratt'
    currentTruss = null
    currentTrussID = ''

    $scope.forms = Object.keys(Trusses)

    $scope.truss = ->
      unless currentTrussID is trussID()
        currentTrussID = trussID()
        currentTruss = Trusses[s.form][s.load](s.span, s.height)
      currentTruss

    trussID = ->
      "#{$scope.formName} #{s.span}x#{s.height} @ #{s.load}"

    $scope.reset = ->
      currentTrussID = trussID()
