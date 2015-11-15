
assert    = require 'assert'
validate  = require '../../src/option-validate'


describe 'Options Validation Functions', ->


  describe 'validate::getContext', ->

    it 'should return "get_context_not_function" when an object is given', ->

      expected  = 'get_context_not_function'
      actual    = validate.getContext {}

      assert.equal expected, actual


    it 'should return "get_context_invalid_arity" when the arity isn\'t 2', ->

      expected  = 'get_context_invalid_arity'

      assert.equal expected, validate.getContext -> null
      assert.equal expected, validate.getContext (one, two, three) -> null
      assert.equal expected, validate.getContext (one) -> null


    it 'should return null when an arity 2 function is given', ->

      expected  = null

      assert.equal expected, validate.getContext (one, two) -> null


  describe  'validate::addroles', ->

    it 'should return "add_roles_not_function" when an object is given', ->

      expected  = 'add_roles_not_function'
      assert.equal expected, validate.addRoles {}


    it 'should return "add_roles_invalid_arity" when the arity isn\'t 3', ->

      expected  = 'add_roles_invalid_arity'
      assert.equal expected, validate.addRoles -> null
      assert.equal expected, validate.addRoles (one) -> null
      assert.equal expected, validate.addRoles (one, two) -> null
      assert.equal expected, validate.addRoles (one, two, three, four) -> null


    it 'should return null when a function with arity 3 is given', ->

      expected  = null
      assert.equal expected, validate.addRoles (one, two, three) -> null
