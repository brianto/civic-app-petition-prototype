window.civic = angular.module "civic", []

window.allValidFn = (validators) ->
  _.chain(validators)
  .map (validator, name) ->
    return validator.isValid() if validator.isValid
    return true
  .all()
  .value()