PI_SQUARED = Math.PI * Math.PI
GRAVITY = 9.81

angular.module('eau.simulation.compression', [
  'eau.simulation.compression.materials'
  'simulation.compression.template'
  'eau.utilities.scientific'
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
  controller: ($scope, MaterialList, MomentShapes)->
    setCurrentMaterial = (materialName) ->
      return unless MaterialList[materialName]?
      $scope.materialName = materialName
      $scope.currentMaterial =
        material: materialName
        density: MaterialList[materialName].density
        elasticity: MaterialList[materialName].elasticity
        color: MaterialList[materialName].color
        stress: MaterialList[materialName].stress

    setCurrentShape = (shape)->
      return unless MomentShapes[shape]?
      $scope.shapeName = shape
      $scope.currentShape =
        shape: shape
        description: MomentShapes[shape].description || shape
        moment: MomentShapes[shape].moment
        crossSection: MomentShapes[shape].crossSection

    $scope.materials = Object.keys MaterialList
    $scope.shapes = Object.keys MomentShapes
    setCurrentMaterial 'Steel'
    setCurrentShape 'Square'

    $scope.$watch 'materialName', (newMaterial)->
      setCurrentMaterial(newMaterial)

    $scope.$watch 'shapeName', (newShape)->
      setCurrentShape newShape

    s = $scope.simulation =
      length: 5
      base: .5
      applied: 0

    $scope.simulation.recalc = ->
      $scope.simulation.applied = $scope.simulation.internal()

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

    $scope.simulation.internal = ->
      ba = $scope.simulation.crossSection()
      l = parseFloat(s.length)
      volume = l * ba
      columnMass = $scope.currentMaterial.density * volume
      columnMass * GRAVITY

    $scope.simulation.compression = ->
      # allowable stress *cross-sectional area
      $scope.currentMaterial.stress * $scope.simulation.crossSection()

    $scope.simulation.deflection = (n)->
      a = $scope.simulation.applied
      b = $scope.simulation.buckle()
      ba = parseFloat(s.base)
      if a > b then ba else 0

    $scope.simulation.failure = ->
      Math.max $scope.simulation.compression(), $scope.simulation.buckle()

    $scope.simulation.failed = ->
      s.applied > s.buckle() or s.applied > s.compression()

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

    $scope.simulation.recalc()
