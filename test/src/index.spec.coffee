

assert      = require 'assert'
Middleware  = require '../../src/index'

testJson    =
  'object': (ctx, id, done) -> done null, if id is '123'
    [ 'object-123' ]
  else []

describe 'Privilege Object Role Middleware', ->
  middleware  = null

  before ->
    map = Middleware.Map()
    map.addHandler 'object', testJson.object

    middleware = Middleware { map: map }


  it 'should fill in additional roles based on the request url', (done) ->

    req =
      originalUrl: '/test/object/123'
      user:
        roles: [ 'test-role' ]

    middleware req, {}, (err) ->
      assert.deepEqual [ 'test-role', 'object-123' ], req.user.roles
      done()

  it 'should accept a custom getContext function', (done) ->

    middleware = Middleware
      map:
        'object': (ctx, id, done) ->
          assert.equal 'my-db-conn', ctx.db
          done null, [ 'object-123' ]

      getContext: (req, done) -> done null,
        user: req.user
        db: 'my-db-conn'

    req =
      originalUrl: '/test/object/123'
      user:
        roles: [ 'test-role' ]

    middleware req, {}, (err) ->
      assert.deepEqual [ 'test-role', 'object-123' ], req.user.roles
      done()

  it 'should forward any getContext errors', (done) ->

    middleware = Middleware
      map:
        'object': (ctx, id, done) ->
          assert.equal 'my-db-conn', ctx.db
          done null, [ 'object-123' ]

      getContext: (req, done) -> done new TypeError 'test-error'

    req =
      originalUrl: '/test/object/123'
      user:
        roles: [ 'test-role' ]

    middleware req, {}, (err) ->
      assert.equal true, err instanceof TypeError
      assert.equal 'test-error', err.message
      done()

  it 'should forward any getRoles errors', (done) ->

    middleware = Middleware
      map:
        'object': (ctx, id, done) -> done new TypeError 'get-role-error'

    req =
      originalUrl: '/test/object/123'
      user:
        roles: [ 'test-role' ]

    middleware req, {}, (err) ->
      assert.equal true, err instanceof Array
      assert.equal true, err[0] instanceof TypeError
      assert.equal 'get-role-error', err[0].message
      done()
