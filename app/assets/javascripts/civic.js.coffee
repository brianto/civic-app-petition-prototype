window.civic = angular.module "civic", []

window.allValidFn = (validators) ->
  return ->
    _.chain(validators)
    .map (validator, name) ->
      return validator.isValid() if validator.isValid
      return true
    .all()
    .value()
