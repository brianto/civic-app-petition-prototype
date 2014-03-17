civic.controller "ResidentFormController", ($scope) ->
  MINIMUM_PASSWORD_LENGTH = 4
  
  $scope.model =
    email: ""
    name: ""
    password: ""
    crypted_password: ""

  $scope.validation =
    allValid: ->
      _.all [
        this.email.isValid()
      ]

    name:
      isValid: ->
        !$scope.model.name.match /^\s*$/
       errorMessage: ->
         "name cannot be empty"
         
    email:
      isValid: ->
        $scope.model.email.match /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}/
      errorMessage: ->
        "e-mail is not a valid e-mail address."

    password:
      validators:
        uppercase: -> !!$scope.model.password.match /[A-Z]/
        lowercase: -> !!$scope.model.password.match /[a-z]/
        numeric:   -> !!$scope.model.password.match /[0-9]/
        length:    -> $scope.model.password.length > MINIMUM_PASSWORD_LENGTH
        
      isValid: ->
        _.chain(this.validators)
          .map (validatorFn, validatorName) -> validatorFn()
          .all()
          .value()
          
      errorMessage: ->
        errors = []
        
        errors.push "no upper case letter" if !this.validators.uppercase()
        errors.push "no lower case letter" if !this.validators.lowercase()
        errors.push "no numeric digit" if !this.validators.numeric()
        errors.push "not long enough" if !this.validators.length()
        
        _.template "password has the following errors: <%= errors %>",
          errors: errors.join ", "
          
    password_confirmation:
      isValid: ->
        model = $scope.model
        model.password == model.password_confirmation
      errorMessage: ->
        "passwords do not match"
        
      
