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
    s = $scope.simulation =
      height: 10 # 2 - 50
      span: 100 # 20 - 400
      load: 'left' # left, middle, right
      bays: 2
    currentTruss = []
    currentTrussID = ''

    $scope.forms = Object.keys(Trusses)
    $scope.setCurrentForm = setCurrentForm = (form)->
      return unless Trusses[form]?
      $scope.formName = form
    setCurrentForm 'Howe'
    $scope.$watch 'formName', (newForm)->
      setCurrentForm newForm

    $scope.truss = ->
      unless currentTrussID is trussID()
        currentTrussID = trussID()
        currentTruss = Trusses[$scope.formName].flat(s.bays).map (beam)->
          beam.map (bar)->
            [bar[0] * s.span / s.bays, bar[1] * s.height]
      currentTruss

    trussID = ->
      "#{$scope.formName} #{s.span}x#{s.height} @ #{s.bays}"

    $scope.reset = ->
      currentTrussID = trussID()

    $scope.truss()
    $scope.reset()
