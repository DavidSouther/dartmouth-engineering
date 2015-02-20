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

    setCurrentShape = (shape)->
      return unless MomentShapes[shape]?
      $scope.currentShape =
        shape: shape
        description: MomentShapes[shape].description || shape
        moment: MomentShapes[shape].moment

    setCurrentMaterial 'Granite'
    setCurrentShape 'Brick'

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
      length: 32.2
      tiparea: 2 * 2
      base: 8
      supported: 0

    $scope.simulation.buckle = ->
      ba = parseFloat(s.base)
      l = parseFloat(s.length)
      e = $scope.currentMaterial.elasticity
      moment = $scope.currentShape.moment(ba)
      buckle = PI_SQUARED * e * moment / (l * l)
      buckle

    $scope.simulation.applied = ->
      ba = parseFloat(s.base)
      ta = parseFloat(s.tiparea)
      l = parseFloat(s.length)
      volume = l * (ba + ta) / 2
      columnMass = $scope.currentMaterial.density * volume
      supportedMass = parseFloat(s.supported)
      (columnMass + supportedMass) * GRAVITY

    $scope.simulation.deflection = (n)->
      n * Math.min(1, ($scope.simulation.applied() / $scope.simulation.buckle()))

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
