### MODULE MECHANISM ###
@module = (names, fn) ->
  names = names.split '.' if typeof names is 'string'
  space = @[names.shift()] ||= {}
  space.module ||= @module
  if names.length
    space.module names, fn
  else
    fn.call space


###
REQUEST ANIMATION FRAME SHIV
###

window.requestAnimFrame = (->
  window.requestAnimationFrame or window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or window.oRequestAnimationFrame or window.msRequestAnimationFrame or (callback, element) ->
    window.setTimeout callback, 1000 / 60
)()

@module "ym", ->
  
  ###
  core module:
  has all core (global?) functionality
  todo: move stuff from tools in here, use it as the global location for all things global
  ###
  
  @module "core", ->
    @methodArray = new Array()
    @currentFrame = 0
    
    ###
    addMethodToEnterFrame method:
    this will add a method to the method array, so it will be executed by animationFrame()
    ###
    
    @addMethodToEnterFrame = (method) ->
      ym.core.methodArray.push(method)
      
      if ym.core.methodArray.length == 1
        ym.core.animationFrame()
    
    @removeMethodToEnterFrame = (method) ->
      i = 0
      while i < ym.core.methodArray.length
        ym.core.methodArray.splice(i,1)  if ym.core.methodArray[i] is method
        i++
      
    ###
    animationFrame method, is a requestAnimationFrame method, will only start running when an method is added to the method array
    ###
    
    @animationFrame = =>
      @currentFrame += 1
      
      execute = (method) ->
        method()
    
      execute method for method in ym.core.methodArray
      
      window.requestAnimFrame ym.core.animationFrame