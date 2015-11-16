// Generated by CoffeeScript 1.10.0
(function() {
  var Middleware, PrivilegeObjectRole, optionParser;

  PrivilegeObjectRole = require('privilege-object-role');

  optionParser = require('./option-parser');

  Middleware = function(options) {
    var addRolesToUser, getContextFromRequest, getRoles, objectHandlerMap, parsedOptions;
    parsedOptions = optionParser(options);
    objectHandlerMap = parsedOptions.map;
    getContextFromRequest = parsedOptions.getContext;
    addRolesToUser = parsedOptions.addRoles;
    getRoles = typeof objectHandlerMap.getRoles === 'function' ? PrivilegeObjectRole(objectHandlerMap) : PrivilegeObjectRole.fromJson(objectHandlerMap);
    return function(req, res, next) {
      return getContextFromRequest(req, function(err, context) {
        if (err) {
          return next(err);
        }
        return getRoles(context, req.originalUrl, function(err, roles) {
          if (err) {
            return next(err);
          }
          return addRolesToUser(req, roles, next);
        });
      });
    };
  };

  Middleware.Map = PrivilegeObjectRole.Map;

  module.exports = Middleware;

}).call(this);
