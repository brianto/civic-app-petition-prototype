# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $("#sign_petition").on "click", ->
    $.ajax
      url: window.location + "/sign" # not much better, andres
      type: "POST"
    .done ->
      document.location = document.URL # reload, the ugly way

  $("#report_petition").on "click", ->
    $.ajax
      url: window.location + "/report"
      type: "POST"
    .done ->
      document.location = document.URL # reload, the ugly way

civic.controller "NewPetitionController", ["$scope", "$sce", ($scope, $sce) ->
  $scope.model =
    title: ""
    statement: ""
    preview: ""

  $scope.error =
    title: ""
    statement: ""

  # TODO this is copy paste from resident.js.coffee
  verify = (key, check, message) ->
    $scope.error[key] = if check then null else message
    check

  $scope.handlers =
    repreview: _.debounce ->
      $.ajax
        url: "/preview"
        type: "POST"
        data:
          statement: $scope.model.statement
        success: (data) ->
          $scope.$apply ->
            $scope.model.preview = $sce.trustAsHtml data
    , 1000 # debounce rate: max 1 call every 1 second

  $scope.validation =
    allValid: ->
      not _.chain($scope.model)
      .map _.isEmpty
      .any()
      .value()

    title: ->
      verify "title", not _.isEmpty($scope.model.title), "title cannot be empty"

    statement: ->
      verify "statement", not _.isEmpty($scope.model.statement), "statement cannot be empty"
  ]

civic.controller "SearchController", ["$scope", ($scope) ->
  SEARCH_URL = _.template "/petitions/find/<%= query %>"

  $scope.deliberatelyTrustDangerousSnippet = (data)->
    $sce.trustAsHtml(data)

  $scope.model =
    query: ""
    results: []

  $scope.handlers =
    navigateTo: (result) ->
      document.location = result.url

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


  ]