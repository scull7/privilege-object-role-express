
PrivilegeObjectRole = require 'privilege-object-role'
optionParser        = require './option-parser'

Middleware  = (options) ->
  parsedOptions         = optionParser options
  objectHandlerMap      = parsedOptions.map
  getContextFromRequest = parsedOptions.getContext
  addRolesToUser        = parsedOptions.addRoles

  getRoles              = PrivilegeObjectRole objectHandlerMap

  (req, res, next) -> getContextFromRequest req, (err, context) ->
    if err then return (next err)

    getRoles context, req.originalUrl, (err, roles) ->
      if err then return (next err)

      addRolesToUser req, roles, next


Middleware.Map  = PrivilegeObjectRole.Map

module.exports  = Middleware
