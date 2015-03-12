angular.module('eau.arrow', [
  'arrow.template'
]).directive('arrow', function(){
  return {
    restrict: 'E',
    replace: true,
    templateNamespace: 'svg',
    templateUrl: 'arrow',
    scope: {
      tip: '=',
      length: '=',
      color: '=',
      rotation: '='
    }
  }
});
