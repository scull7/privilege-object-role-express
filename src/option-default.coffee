

_validateContext  = (ctx) ->
  errMsg  = switch
    when not ctx then 'request_not_valid'
    when not ctx.user then 'user_not_found'
    when not ctx.user.roles then 'user_roles_not_found'
    else null

  return if errMsg then (new TypeError errMsg) else null

getContext  = (req, done) ->
  err  = _validateContext req

  if err then done(err) else done(null, { user: req.user })


addRoles  = (context, roles, done) ->
  err = _validateContext context

  if err then done(err) else
    context.user.roles  = context.user.roles.concat roles
    done null, context


module.exports  =
  getContext    : getContext
  addRoles      : addRoles
