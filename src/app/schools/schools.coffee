angular.module( 'ngPeacemakers.schools', [
  'ui.state',
  'ngResource'
])

.config ( $stateProvider ) ->
  $stateProvider.state 'schools',
    url: '/schools'
    views:
      "main":
        controller: 'SchoolsCtrl'
        templateUrl: 'schools/schools.tpl.html'
    data:
      pageTitle: 'Schools'

.controller 'SchoolsCtrl', ( $scope, SchoolsRes ) ->
  $scope.schools = SchoolsRes.query()

.factory 'SchoolsRes', ( $resource ) ->
  $resource 'http://localhost:3000/api/schools'