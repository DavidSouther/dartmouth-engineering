PI_SQUARED = Math.PI * Math.PI
GRAVITY = 9.81

angular.module('eau.simulation.compression', [
  'eau.simulation.compression.materials'
  'simulation.compression.template'
  'eau.utilities.scientific'
  'eau.simulation.compression.show-select'
  'graphing.scales'
  'graphing.svg'
  'ngMaterial'
])
.config ['SimulationNavProvider', (sims)->
  sims.sim 'compression',
    title: 'Column Compression'
]
.directive 'compression', ->
  restrict: 'E'
  templateUrl: 'simulation/compression'
  controller: ($scope, MaterialList, MomentShapes, $mdDialog)->
    setCurrentMaterial = (materialName) ->
      return unless MaterialList[materialName]?
      $scope.currentMaterial =
        material: materialName
        density: MaterialList[materialName].density
        elasticity: MaterialList[materialName].elasticity
        color: MaterialList[materialName].color
        stress: MaterialList[materialName].stress

    setCurrentShape = (shape)->
      return unless MomentShapes[shape]?
      $scope.currentShape =
        shape: shape
        description: MomentShapes[shape].description || shape
        moment: MomentShapes[shape].moment
        crossSection: MomentShapes[shape].crossSection

    setCurrentMaterial 'Steel'
    # setCurrentShape 'Square'
    setCurrentShape 'Hollow Pipe'

    _supportWeightSlide = 0
    $scope.supportedWeightSlide = (newVal) ->
      # This is being called way too much it's an issue
      # Don't know what the best solution might be
      if not angular.isDefined newVal
        return _supportWeightSlide
      convertedVal = newVal / 100
      $scope.simulation.supported = convertedVal
      _supportWeightSlide = newVal

    s = $scope.simulation =
      length: 5
      base: .5
      supported: 0

    $scope.simulation.crossSection = ->
      ba = parseFloat(s.base)
      $scope.currentShape.crossSection(ba)

    $scope.simulation.buckle = ->
      ba = $scope.simulation.crossSection()
      l = parseFloat(s.length)
      e = $scope.currentMaterial.elasticity
      moment = $scope.currentShape.moment(ba)
      buckle = PI_SQUARED * e * moment / (l * l)
      buckle

    $scope.simulation.applied = ->
      ba = $scope.simulation.crossSection()
      l = parseFloat(s.length)
      volume = l * ba
      columnMass = $scope.currentMaterial.density * volume
      supportedMass = parseFloat(s.supported)
      (columnMass + supportedMass) * GRAVITY

    $scope.simulation.compression = ->
      # allowable stress *cross-sectional area
      $scope.currentMaterial.stress * $scope.simulation.crossSection()

    $scope.simulation.deflection = (n)->
      a = $scope.simulation.applied()
      b = $scope.simulation.buckle()
      ba = parseFloat(s.base)
      if a > b
        Math.min ba * (a / b), 2
      else
        0

    $scope.simulation.showMaterialList = (event) ->
      event.preventDefault
      showObj =
        templateUrl: 'simulation/compression/show-select'
        controller: 'ShowSelectCtrl'
        parent: event.target
        hasBackdrop: false
        clickOutsideToClose: false
        locals:
          options: Object.keys MaterialList

      $mdDialog.show(showObj)
        .then( (materialName) ->
          setCurrentMaterial materialName
        )

    $scope.simulation.showMomentList = (event) ->
      event.preventDefault
      showObj =
        templateUrl: 'simulation/compression/show-select'
        controller: 'ShowSelectCtrl'
        parent: event.target
        hasBackdrop: false
        clickOutsideToClose: false
        locals:
          options: Object.keys MomentShapes

      $mdDialog.show(showObj)
        .then( (momentName) ->
          setCurrentShape momentName
        )
