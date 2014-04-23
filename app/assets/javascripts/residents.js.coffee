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
    
  makeValidator = (checkFn, error) ->
    ->
      valid: checkFn()
      error: error

  passwordValidators =
    uppercase: makeValidator ->
      !!$scope.model.password.match /[A-Z]/
    , "no upper case letter"
      
    lowercase: makeValidator ->
      !!$scope.model.password.match /[a-z]/
    , "no lower case letter"
      
    numeric: makeValidator ->
      !!$scope.model.password.match /[0-9]/
    , "no numeric digit"
      
    length: makeValidator ->
      $scope.model.password.length > MINIMUM_PASSWORD_LENGTH
    , "not long enough"
      
  $scope.updateError = (key) ->
    validator = $scope.validation[key]()
    $scope.error[key] = if validator.valid then "" else validator.error

  $scope.allValid = ->
    present = not _.chain($scope.model)
    .map _.isEmpty
    .any()
    .value()

    valid = _.chain($scope.validation)
    .map (validatorFn, validatorName) ->
      validatorFn().valid
    .all()
    .value()

    present and valid

  $scope.validation =
    name: makeValidator ->
      !$scope.model.name.match(/^\s*$/)
    , "name cannot be empty"

    email: makeValidator ->
      !!$scope.model.email.match(/[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}/)
    , "email is not valid"
      
    password: ->
      validator = _.reduce passwordValidators, (memo, validatorFn, validatorName) ->
        v = validatorFn()
        
        memo.valid = memo.valid and v.valid
        memo.error.push(v.error) if not v.valid
         
        memo
      , { valid: true, error: [] }
          
      validator.error = _.template "password has the following errors: <%= errors %>",
        errors: validator.error.join ", "
      
      validator
      
    password_confirmation: makeValidator ->
      model = $scope.model
      model.password_confirmation == model.password
    , "passwords do not match"
  ]