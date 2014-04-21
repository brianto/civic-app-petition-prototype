civic.controller "ResidentFormController", ["$scope", ($scope) ->
  MINIMUM_PASSWORD_LENGTH = 4
  
  $scope.model =
    email: ""
    name: ""
    password: ""
    password_confirmation: ""

  $scope.error =
    email: ""
    name: ""
    password: ""
    password_confirmation: ""

  passwordValidators =
    uppercase: -> !!$scope.model.password.match /[A-Z]/
    lowercase: -> !!$scope.model.password.match /[a-z]/
    numeric:   -> !!$scope.model.password.match /[0-9]/
    length:    -> $scope.model.password.length > MINIMUM_PASSWORD_LENGTH

  verify = (key, check, message) ->
    $scope.error[key] = if check then null else message
    check

  $scope.validation =
    allValid: ->
      present = not _.chain($scope.model)
      .map _.isEmpty
      .any()
      .value()

      valid = _.chain($scope.model)
      .map _.isEmpty
      .all()
      .value()

      present and valid

    name: -> verify "name", !$scope.model.name.match(/^\s*$/), "name cannot be empty"
    email: -> verify "email", $scope.model.email.match(/[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}/), "email is not valid"
    password: ->
      valid = _.chain(passwordValidators)
        .map (validatorFn, validatorName) ->
          console.log validatorName
          validatorFn()
        .all()
        .value()
          
      errors = []
      
      errors.push "no upper case letter" if !passwordValidators.uppercase()
      errors.push "no lower case letter" if !passwordValidators.lowercase()
      errors.push "no numeric digit" if !passwordValidators.numeric()
      errors.push "not long enough" if !passwordValidators.length()
      
      if _.isEmpty errors
        $scope.error.password = ""
      else
        $scope.error.password = _.template "password has the following errors: <%= errors %>",
          errors: errors.join ", "

      valid
          
    password_confirmation: ->
      model = $scope.model
      verify "password_confirmation", model.password_confirmation == model.password, "passwords do not match"
  ]