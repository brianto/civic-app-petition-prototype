# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".sign_petition").on "click", ->
    $.ajax
      url: window.location + "/sign" # not much better, andres
      type: "POST"
    .done ->
      document.location = document.URL # reload, the ugly way

civic.controller "SearchController", ($scope) ->
  SEARCH_URL = _.template "/petitions/find/<%= query %>"
  
  $scope.model =
    query: ""
    results: []

  $scope.handlers =
    search: ->
      if _.isEmpty $scope.model.query
        $scope.model.results = []
        return
      
      $.ajax
        url: SEARCH_URL
          query: $scope.model.query
      .done (results) ->
        $scope.$apply ->
          $scope.model.results = results
