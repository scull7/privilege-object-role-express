
assert  = require 'assert'
parser  = require '../../src/option-parser'

_errorTest  = (errorType, errorMsg, testOptions) ->
  try
    parser testOptions
  catch e
    assert.equal true, e instanceof errorType
    assert.equal errorMsg, e.message
    return

  throw new Error "Expected error to be throw: #{errorMsg}"

describe 'Option Parser', ->

  it 'should throw a TypeError if the map option is not set', ->
    _errorTest TypeError, 'map_required', {}


  it 'should return a default getContext function if not user provieded', ->

    parsed  = parser { map: {} }
    assert.equal 'function', typeof parsed.getContext

  it 'should throw a TypeError if the getContext function is not valid', ->
    _errorTest TypeError, 'get_context_invalid_arity',
      map: {}
      getContext: -> null


  it 'should return a default addRoles function if not user provided', ->

    parsed  = parser { map: {} }
    assert.equal 'function', typeof parsed.addRoles


  it 'should throw a TypeError if the addRoles function is not valid', ->
    _errorTest TypeError, 'add_roles_invalid_arity',
      map: {}
      addRoles: -> null
