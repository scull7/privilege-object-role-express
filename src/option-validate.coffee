
_validateFnFactory = (name, arity) -> (fn) -> switch
  when typeof fn isnt 'function' then "#{name}_not_function"
  when fn.length isnt arity then "#{name}_invalid_arity"
  else null


module.exports  =
  getContext    : _validateFnFactory('get_context', 2)
  addRoles      : _validateFnFactory('add_roles', 3)
