@module "ym", ->
  @module "animations", ->
    
    @varible = false
          
    @doStuff = ->
     console.log "Do Stuff"
     
     tempObject = {x: 0, y: 0}
     ym.tween.start();
     ym.tween.to(tempObject, parseInt(100), {x: 20, y: 30});
     
    @animate = (obj, properties, delay, onCompleteProperties) ->
    
      onComplete = (obj, completeProperties) ->
        if @supportsTransitions()
          obj.removeEventListener ym.tools.transEndName, listener, false
    
        for attr, value of completeProperties
          obj.style[attr] = value
    
      listener = ->
        onComplete obj, onCompleteProperties
    
      if delay == undefined
        delay = 0
    
      # CSS3 ANIMATION
      if @supportsTransitions()
        if onCompleteProperties != undefined
          obj.addEventListener ym.tools.transEndName, listener, false
    
        obj.style[ym.tools.transition] = "all 500ms cubic-bezier(0.190, 1.000, 0.220, 1.000) " + delay + "ms";
    
        for attr, value of properties
          obj.style[attr] = value
          
      # JQUERY
      else
        $(obj).delay(delay).animate properties, 
          duration: 500
          ease: "easeOutExpo"
          complete: listener
    
    # TODO: Move this in to somewhere better
    @supportsTransitions = ->
      div = document.createElement("div")
      vendors = "Khtml Ms O Moz Webkit".split(" ")
      len = vendors.length
      (prop) ->
        return true  if prop of div.style
        prop = prop.replace(/^[a-z]/, (val) ->
          val.toUpperCase()
        )
        return true  if vendors[len] + prop of div.style  while len--
        false
      