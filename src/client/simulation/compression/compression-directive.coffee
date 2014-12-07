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
  controller: ($scope, MaterialList, $mdDialog)->
    setCurrentMaterial = (materialName) ->
      if not MaterialList.hasOwnProperty materialName
        return
      $scope.currentMaterial =
        material: materialName
        density: MaterialList[materialName].density
        elasticity: MaterialList[materialName].elasticity

    setCurrentMaterial 'Granite'

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
      basearea: 8 * 8
      supported: 0

    $scope.simulation.buckle = ->
      ba = parseFloat(s.basearea)
      l = parseFloat(s.length)
      e = $scope.currentMaterial.elasticity
      moment = (ba * ba) / 12
      buckle = PI_SQUARED * e * moment / (l * l)
      buckle

    $scope.simulation.applied = ->
      ba = parseFloat(s.basearea)
      ta = parseFloat(s.tiparea)
      l = parseFloat(s.length)
      volume = l * (ba + ta) / 2
      columnMass = $scope.currentMaterial.density * volume
      supportedMass = parseFloat(s.supported)
      (columnMass + supportedMass) * GRAVITY

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
