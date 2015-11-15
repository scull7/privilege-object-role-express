

getContext  = (req, done) ->
  errMsg = switch
    when not req.user then 'user_not_found'
    when not req.user.roles then 'user_roles_not_found'
    else null

  if errMsg
    done (new TypeError errMsg)
  else
    done { user: req.user }


addRoles  = (req, roles, done) -> getContext req, (err, ctx) ->
  if err
    done err
  else
    done null, (ctx.user.roles.concat roles)


module.exports  =
  getContext    : getContext
  addRoles      : addRoles
