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

  $scope.validation =
    allValid: allValidFn this

    title:
      isValid: ->
        not _.isEmpty $scope.model.title
      errorMessage: ->
        "Title cannot be empty"

    statement:
      isValid: ->
        not _.isEmpty $scope.model.statement
      errorMessage: ->
        "Statement cannot be empty"

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