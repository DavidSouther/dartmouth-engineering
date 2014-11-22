angular.module('eau.head-controller', [
    'eau.title-service'
]).controller('HeadCtrl', function($scope, TitleSvc){
    $scope.title = TitleSvc.title;
});
