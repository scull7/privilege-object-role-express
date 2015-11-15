
assert    = require 'assert'
defaults  = require '../../src/option-default'

_assertIsError = (type, msg, done) -> (err) ->
  assert.equal msg, err.message
  assert.equal true, (err instanceof type)
  done()

_contextTypeErrorTest = (message, request, done) ->
  handler = _assertIsError TypeError, message, done
  defaults.getContext request, handler

_addRolesTypeErrorTest = (message, ctx, done) ->
  handler = _assertIsError TypeError, message, done
  defaults.addRoles ctx, [ 'test' ], handler

describe 'Default Option Functions', ->


  describe 'getContext', ->

    it 'should be a function with an arity of 2', ->
      assert.equal 2, defaults.getContext.length


    it 'should throw a TypeError when the req is null', (done) ->
      _contextTypeErrorTest 'request_not_valid', null, done


    it 'should throw a TypeError when the req is undefined', (done) ->
      _contextTypeErrorTest 'request_not_valid', undefined, done


    it 'should throw a type error when the req.user key is not present',
    (done) ->
      _contextTypeErrorTest 'user_not_found', {}, done


    it 'should throw a type error the req.user.roles is not present', (done) ->
      _contextTypeErrorTest 'user_roles_not_found', { user: {} }, done


    it 'should return a context object that contains req.user', (done) ->

      expected  = { user: roles: [ 'test' ] }
      request   =
        user: roles: [ 'test' ]
        thing: 'one'

      defaults.getContext request, (err, ctx) ->
        assert.equal null, err
        assert.deepEqual expected, ctx
        done()


  describe 'addRoles', ->

    it 'should be a function with an arity of 3', ->
      assert.equal 3, defaults.addRoles.length


    it 'should throw a TypeError when the context is null', (done) ->
      _addRolesTypeErrorTest 'request_not_valid', null, done


    it 'should throw a TypeError when the context is undefined', (done) ->
      _addRolesTypeErrorTest 'request_not_valid', undefined, done


    it 'should throw a TypeError when req.user key is not present', (done) ->
      _addRolesTypeErrorTest 'user_not_found', {}, done


    it 'should throw a TypeError when req.user.roles is not present', (done) ->
      _addRolesTypeErrorTest 'user_roles_not_found', { user: {} }, done


    it 'should return the context with the given roles added to the current ' +
    'set of user roles', (done) ->

      context   =
        user:
          roles: [ 'test1' ]

      expected  =
        user:
          roles: [ 'test1', 'test2', 'test3' ]


      defaults.addRoles context, [ 'test2', 'test3' ], (err, ctx) ->
        assert.equal err, null
        assert.deepEqual expected, ctx
        done()
