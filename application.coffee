class GameState 
 constructor:(@rows,@cols) ->
    @cells = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
    above = ((index - @rows) + @cells.length) % @cells.length 
    below = (Math.abs(index + @cols)) % @cells.length 
    @cells[below - 1] + 
    @cells[below] + 
    @cells[below + 1] + 
    @cells[index - 1] + 
    @cells[index + 1] + 
    @cells[above - 1] + 
    @cells[above] + 
    @cells[above + 1] 

  iterate: ->
    newState = [] 
    for cell, index in @cells
      ncount = this.neighbors(cell, index)
      newState[index] = 
        if cell is 1 
          if ncount < 2 then 0 
          else  
            if ncount is 2 or ncount is 3 then 1 else 0
        else
          if ncount is 3 then 1 else 0
    @cells = newState 

class Game
  constructor:(@canvas,@state) ->
                
  draw: () ->
    blocksize =  @canvas.width / @state.rows 
    if @canvas.getContext 
      ctx = @canvas.getContext("2d")
      ctx.clearRect(0, 0, @canvas.width, @canvas.height)  
      for cell, i in @state.cells when cell is 1
        ctx.fillStyle = "rgb(200,0,0)" 
        x = (i % @state.cols) * blocksize
        y = parseInt(i / @state.rows) * blocksize 
        ctx.fillRect(x, y, blocksize, blocksize) 

  tick: ->
   this.draw()
   @state.iterate()

  
$(window.document).ready ->
  canvas = $("#canvas")[0]
  state = new GameState(10,10)
  game = new Game(canvas, state) 
  expression = () -> game.tick()
  window.timer = window.setInterval(expression, 100)
