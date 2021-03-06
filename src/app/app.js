angular.module( 'ngPeacemakers', [
  'templates-app',
  'templates-common',
  'ngPeacemakers.home',
  'ngPeacemakers.about',
  'ngPeacemakers.schools',
  'ui.state',
  'ui.route'
])

.config( function myAppConfig ( $stateProvider, $urlRouterProvider ) {
  $urlRouterProvider.otherwise( '/home' );
})

.run( function run () {
})

.controller( 'AppCtrl', function AppCtrl ( $scope, $location ) {
  $scope.$on('$stateChangeSuccess', function(event, toState, toParams, fromState, fromParams){
    if ( angular.isDefined( toState.data.pageTitle ) ) {
      $scope.pageTitle = toState.data.pageTitle + ' | Peacemakers' ;
    }
  });
})

;

