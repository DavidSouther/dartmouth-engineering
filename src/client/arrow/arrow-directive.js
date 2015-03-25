var toRad = Math.PI / 180;
ArrowController.$inject = ['$scope'];
function ArrowController($scope){
  this.fill = this.fill || this.color;
  $scope.sin = function(thetaDeg){
    return Math.sin(thetaDeg * toRad);
  };
  $scope.cos = function(thetaDeg){
    return Math.cos(thetaDeg * toRad);
  };
}

angular.module('eau.arrow', [
  'arrow.template'
]).directive('arrow', function(){
  return {
    restrict: 'E',
    replace: true,
    templateNamespace: 'svg',
    templateUrl: 'arrow',
    controller: ArrowController,
    controllerAs: 'arrow',
    bindToController: true,
    scope: {
      tip: '=',
      length: '=',
      color: '=',
      rotation: '=',
      point: '=',
      fill: '@',
      weight: '@'
    }
  };
});
