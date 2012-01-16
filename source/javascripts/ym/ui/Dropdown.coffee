###
First check if there is a module class, if not create a new one
###

if !@module
  @module = (names, fn) ->
    names = names.split '.' if typeof names is 'string'
    space = @[names.shift()] ||= {}
    space.module ||= @module
    if names.length
      space.module names, fn
    else
      fn.call space

### 
YM.Dropdown
###
@module "ym", ->
	
	class @Dropdown	
    
    ###
    constructor method:
    construct the Dropdown class, prepares some variables
    takes a html element and some options as input
    ###
    
    constructor: ( @element, @options ) ->
      ### Construct the dropdown ###
    
    ###
    init method:
    initializes the module
    finds all images and tell them to start preloading
    ###
    
    init: ->
      
      ### Store all elements and bind events ###
      @hasTouch = document.createTouch?
      @open = false
      
      @elements = @element.getElementsByTagName("*")
      @label = @elements[0]
      @options = @elements[1]
      
      @label[(if @hasTouch then "ontouchstart" else "onmousedown")] = (e) =>
        @toggle()
        
    toggle: ->
      console.log "I Should toggle"
      
      properties = marginLeft: "12px", marginTop: "12px"
      ym.animations.animate @options, properties
