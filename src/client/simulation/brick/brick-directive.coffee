angular.module('eau.simulation.brick', [
  'graphing.svg'
  'simulation.brick.brick-template.template'
])
.controller('BrickCtrl', () ->
  @positionMultiplier =
    if @positionMultiplier > 0
      @positionMultiplier
    else
      1
  @getX = ->
    parseInt(@x * @positionMultiplier)
  @getY = ->
    parseInt(@y * @positionMultiplier)

  return
)
.directive('brick', ->
  restrict: 'E'
  templateUrl: 'simulation/brick/brick-template'
  scope:
    x: '='
    y: '='
    positionMultiplier: '='
  bindToController: true
  controller: 'BrickCtrl'
  controllerAs: 'brickCtrl'
)
