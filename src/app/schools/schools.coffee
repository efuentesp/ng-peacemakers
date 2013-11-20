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
      pageTitle: 'Escuelas'


# List Schools
.controller 'SchoolsCtrl', ( $scope, SchoolsRes, $dialog ) ->
  $scope.schools = SchoolsRes.query()

  $scope.createSchool = (school) ->
    $scope.myDialog = $dialog.dialog
      keyboard: true
      dialogFade: true
      backdropClick: false
      resolve: 
        school: ->
          new SchoolsRes()
    $scope.myDialog.open('schools/school_create.tpl.html', 'SchoolCreateCtrl')
      .then (result) ->
        $scope.schools = SchoolsRes.query() if result isnt 'cancel'

  $scope.editSchool = (school) ->
    $scope.myDialog = $dialog.dialog
      keyboard: true
      dialogFade: true
      backdropClick: false
      resolve: 
        school: ->
          angular.copy(school)
    $scope.myDialog.open('schools/school_edit.tpl.html', 'SchoolEditCtrl')
      .then (result) ->
        $scope.schools = SchoolsRes.query() if result isnt 'cancel'

  $scope.deleteSchool = (school) ->
    console.log school
    $scope.myDialog = $dialog.dialog
      keyboard: true
      dialogFade: true
      backdropClick: false
      resolve: 
        school: ->
          angular.copy(school)
    $scope.myDialog.open('schools/school_delete.tpl.html', 'SchoolDeleteCtrl')
      .then (result) ->
        $scope.schools = SchoolsRes.query() if result isnt 'cancel'


# Create School
.controller 'SchoolCreateCtrl', ($scope, SchoolsRes, dialog, school) ->
  $scope.school = school

  $scope.submit = ->
    $scope.school.$save (data) ->
      dialog.close($scope.school)

  $scope.cancel = ->
    dialog.close 'cancel'


# Edit School
.controller 'SchoolEditCtrl', ($scope, SchoolsRes, dialog, school) ->
  $scope.school = school

  $scope.submit = ->
    $scope.school.$update (data) ->
      dialog.close($scope.school)

  $scope.cancel = ->
    dialog.close 'cancel'


# Delete School
.controller 'SchoolDeleteCtrl', ($scope, SchoolsRes, dialog, school) ->
  $scope.school = school

  $scope.submit = ->
    $scope.school.$remove (data) ->
      dialog.close($scope.school)

  $scope.cancel = ->
    dialog.close 'cancel'


# School Factory
.factory 'SchoolsRes', ( $resource ) ->
  #$resource 'http://localhost:3000/api/schools'
  $resource 'http://localhost:3000/api/schools/:id', {id: '@_id'}, {'update': {method: 'PUT'}}