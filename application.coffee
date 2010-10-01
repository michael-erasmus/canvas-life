ROWS = 10
COLS = 10

state = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 1, 1, 1, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 1, 1, 1, 0, 0, 0, 0, 0,
         0, 0, 0, 1, 1, 1, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]

draw = () ->
  canvas = $("#canvas")[0]
  Blocksize =  canvas.width / ROWS 
  if canvas.getContext 
    ctx = canvas.getContext("2d")
    ctx.clearRect(0, 0, canvas.width, canvas.height)  
    for cell, i in state when cell is 1
      ctx.fillStyle = "rgb(200,0,0)" 
      x = (i % COLS) * Blocksize
      y = parseInt(i / ROWS) * Blocksize 
      ctx.fillRect(x, y, Blocksize, Blocksize) 
  
neighbors = (cell, index) ->
  above = ((index - ROWS) + state.length) % state.length 
  below = (Math.abs(index + COLS)) % state.length 
  state[below - 1] + state[below] + state[below + 1] + state[index - 1] + state[index + 1] + state[above - 1] + state[above] + state[above + 1] 
  
iterate = () ->
  draw()      
  newState = [] 
  for cell, index in state
    ncount = neighbors(cell, index)
    newState[index] = 
      if cell is 1 
        if ncount < 2 then 0 #lonely cell dies
        else  
          if ncount is 2 or ncount is 3 then 1 else 0
      else
        if ncount is 3 then 1 else 0
  
  state = newState

$(window.document).ready -> 
  timer = window.setInterval(iterate, 100)
