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

  # Live preview things
  update =  ->
    text = $("#petition_statement").val()
    $.ajax
      url: "/preview"
      type: 'POST'
      data: {statement: text}
      success: (data) ->
        $("#preview_pane").html(data)
        console.log "Got called"
        console.log data

  timer = $.timer(update, 3000, false) #Update the page every 3s

  $("#petition_statement").on "focus", ->
    timer.play(true) # Start the live updater every 3s

  $("#petition_statement").on "blur", ->
    timer.pause() #Stop the updating
    timer.once()  #Call it one last time


civic.controller "NewPetitionController", ($scope) ->
  $scope.model =
    title: ""
    statement: ""

  $scope.error =
    title: ""
    statement: ""

  # TODO this is copy paste from resident.js.coffee
  verify = (key, check, message) ->
    $scope.error[key] = if check then null else message
    check

  $scope.validation =
    allValid: ->
      not _.chain($scope.model)
      .map _.isEmpty
      .any()
      .value()

    title: ->
      verify 'title', not _.isEmpty($scope.model.title), "title cannot be empty"

    statement: ->
      verify 'statement', not _.isEmpty($scope.model.statement), "statement cannot be empty"

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
