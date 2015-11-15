{
  fromJson
}           = require 'privilege-object-role'
validate    = require './option-validate'
defaults    = require './option-default'

_validate   = (validator, value) ->
  errMsg  = validator value
  throw new TypeError errMsg if errMsg

  return value

_maybeWithDefault = (_default, value) -> if value then value else _default

parser  = (options) ->

  {
    map
    getContext
    addRoles
  }           = options


  throw new TypeError 'map_required' if not map

  map = fromJson map if typeof map.getRoles isnt 'function'


  return {
    map         : map
    getContext  : _validate(
      validate.getContext,
      (_maybeWithDefault defaults.getContext, getContext)
    )
    addRoles    : _validate(
      validate.addRoles,
      (_maybeWithDefault defaults.addRoles, addRoles)
    )
  }

module.exports  = parser
