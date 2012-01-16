@module "ym", ->
  @module "tween", ->
    
    @activeTweens = []
    @running = false
    
    @start = ->
      ym.core.addMethodToEnterFrame(@update);
      @running = true
      
    @stop = ->
      ym.core.removeMethodToEnterFrame(@update);
      @running = false
    
    @to = (obj, time, params) ->
      sparams = {}
      for i of params
        sparams[i] = obj[i]
      t = new @Tween(obj, time, sparams, params)
      @activeTweens.push t
      
    @update = =>
      now = new Date().getTime()
      for i of @activeTweens
        t = @activeTweens[i]
        completeness = (now - t.startTime) / (t.endTime - t.startTime)
        if completeness < 1
          for i of t.endParams
            t.obj[i] = t.startParams[i] + (t.endParams[i] - t.startParams[i]) * Math.sin(completeness * 0.5 * Math.PI)
        else
          delete @activeTweens[i]
    
    @Tween = (obj, time, startParams, endParams) ->
      @obj = obj
      @startParams = startParams
      @endParams = endParams
      @startTime = new Date().getTime()
      @endTime = @startTime + time
