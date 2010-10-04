class Game
  constructor:(@canvas,@rows,@cols) ->
    @state = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 1, 1, 1, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 1, 1, 1, 0, 0, 0, 0, 0,
              0, 0, 0, 1, 1, 1, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]

  neighbors:(cell, index) ->
    above = ((index - @rows) + @state.length) % @state.length 
    below = (Math.abs(index + @cols)) % @state.length 
    @state[below - 1] + 
    @state[below] + 
    @state[below + 1] + 
    @state[index - 1] + 
    @state[index + 1] + 
    @state[above - 1] + 
    @state[above] + 
    @state[above + 1] 

  draw: ->
    blocksize =  @canvas.width / @rows 
    if @canvas.getContext 
      ctx = @canvas.getContext("2d")
      ctx.clearRect(0, 0, @canvas.width, @canvas.height)  
      for cell, i in @state when cell is 1
        ctx.fillStyle = "rgb(200,0,0)" 
        x = (i % @cols) * blocksize
        y = parseInt(i / @rows) * blocksize 
        ctx.fillRect(x, y, blocksize, blocksize) 

  iterate: ->
    newState = [] 
    for cell, index in @state
      ncount = this.neighbors(cell, index)
      newState[index] = 
        if cell is 1 
          if ncount < 2 then 0 
          else  
            if ncount is 2 or ncount is 3 then 1 else 0
        else
          if ncount is 3 then 1 else 0
    @state = newState 
    
tick = () ->
 window.game.draw()
 window.game.iterate()
  
$(window.document).ready ->
  canvas = $("#canvas")[0]
  window.game = new Game(canvas, 10, 10)
  window.timer = window.setInterval(tick, 100)
