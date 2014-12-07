angular.module('eau.simulation.compression.show-select', [
  'simulation.compression.show-select.template'
  'ngMaterial'
])
.controller 'ShowSelectCtrl', ($scope, $mdDialog, options) ->
    $scope.options = options
    $scope.selected = (name) ->
      $mdDialog.hide(name)

