PI_SQUARED = Math.PI * Math.PI
GRAVITY = 9.81

angular.module('eau.simulation.compression', [
  'eau.simulation.compression.materials'
  'simulation.compression.template'
  'eau.utilities.scientific'
  'graphing.scales'
  'graphing.svg'
  'ngMaterial'
  'eau.navigation'
])
.config ['SimulationNavProvider', (sims)->
  sims.sim 'compression',
    title: 'Column Compression'
]
.directive 'compression', ->
  restrict: 'E'
  templateUrl: 'simulation/compression'
  controller: ($scope, MaterialList, MomentShapes)->
    $scope.setCurrentMaterial = setCurrentMaterial = (materialName) ->
      return unless MaterialList[materialName]?
      $scope.materialName = materialName
      $scope.currentMaterial =
        material: materialName
        density: MaterialList[materialName].density
        elasticity: MaterialList[materialName].elasticity
        color: MaterialList[materialName].color
        stress: MaterialList[materialName].stress

    $scope.setCurrentShape = setCurrentShape = (shape)->
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
      $scope.resetLoad()
      setCurrentMaterial(newMaterial)

    $scope.$watch 'shapeName', (newShape)->
      $scope.resetLoad()
      setCurrentShape newShape

    s = $scope.simulation =
      length: 2
      base: .25

    $scope.simulation.crossSection = ->
      ba = parseFloat(s.base)
      $scope.currentShape.crossSection(ba)

    $scope.simulation.moment = ->
      $scope.currentShape.moment($scope.simulation.base)

    $scope.simulation.buckle = ->
      ba = $scope.simulation.crossSection()
      l = parseFloat(s.length)
      e = $scope.currentMaterial.elasticity
      moment = $scope.simulation.moment()
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
      return 0 if $scope.simulation.compression() < $scope.simulation.buckle()
      a = $scope.simulation.applied
      b = $scope.simulation.buckle()
      ba = parseFloat(s.base)
      if a > b then ba else 0

    $scope.simulation.failure = ->
      Math.min $scope.simulation.compression(), $scope.simulation.buckle()

    $scope.simulation.failed = ->
      s.applied > s.buckle() or s.applied > s.compression()

    $scope.showLoad = no
    $scope.resetLoad = ->
      $scope.showLoad = no
      $scope.simulation.applied = 1
    $scope.$watch 'simulation.length', -> $scope.resetLoad()
    $scope.$watch 'simulation.base', -> $scope.resetLoad()
    $scope.calcLoad = ->
      $scope.simulation.applied = $scope.simulation.failure()
      $scope.showLoad = yes
