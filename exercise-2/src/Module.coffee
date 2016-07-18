moduleKeywords = [ 'extended', 'included' ]
class Module
  @extend: (obj) ->
    @[key] = value for key, value of obj when key not in moduleKeywords
    obj.extended?.apply(@)
    @

  @include: (obj) ->
    @::[key] = value for key, value of obj when key not in moduleKeywords
    obj.included?.apply(@)
    @

module.exports.Module = Module
