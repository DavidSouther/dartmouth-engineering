angular.module('eau.simulation.truss', [
  'eau.simulation.truss.shapes'
  'eau.simulation.compression.materials',
  'simulation.truss.template'
  'eau.utilities.scientific'
  'eau.arrow'
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
        min: 10
        max: 6270

    $scope.loading = [
      'Center',
      'Left',
      'Even'
    ]
    s = $scope.simulation =
      height: 3
      span: 40
      load: 120
      loading: $scope.loading[0]
      form: 'Howe'
    currentTruss = null
    currentTrussID = ''

    $scope.forms = Object.keys(Trusses)

    $scope.truss = ->
      unless currentTrussID is trussID()
        currentTrussID = trussID()
        currentTruss = Trusses[s.form][s.loading](s.span, s.height, s.load)
      currentTruss

    trussID = ->
      "#{s.form} #{s.span}x#{s.height} @  #{s.load}kN #{s.loading}"

    $scope.reset = ->
      currentTrussID = trussID()
