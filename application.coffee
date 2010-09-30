
state = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
         0, 1, 0, 0, 0, 0, 0, 0, 1, 0,
         0, 0, 1, 0, 0, 0, 0, 0, 1, 0,
         0, 1, 0, 1, 0, 0, 0, 0, 1, 0,
         0, 1, 0, 1, 0, 1, 0, 0, 1, 0,
         0, 1, 1, 0, 0, 0, 0, 0, 1, 0,
         0, 1, 0, 1, 0, 0, 0, 0, 1, 0,
         0, 1, 1, 0, 0, 0, 0, 0, 1, 0,
         0, 1, 0, 0, 0, 0, 0, 0, 1, 0,
         0, 1, 0, 0, 0, 0, 0, 0, 1, 0 ]

draw = () ->
  canvas = window.document.getElementById("canvas")
  if canvas.getContext 
    ctx = canvas.getContext("2d")
    ctx.clearRect(0, 0, canvas.width, canvas.height)  
    for cell, i in state when cell is 1
      ctx.fillStyle = "rgb(200,0,0)" 
      x = (i % 10) * 10 
      y = parseInt(i / 10) * 10  
      ctx.fillRect(x, y, 10, 10) 
  
neighbors = (cell, index) ->
  above = ((index - 10) + 100) % 100
  below = (Math.abs(index + 10)) % 100
  state[above - 1] + state[below] + state[below + 1] + state[index - 1] + state[index + 1] + state[above - 1] + state[above] + state[above + 1] 
  
iterate = () ->
  draw()      
  newState = [] 
  for cell, index in state
    ncount = neighbors(cell, index)
    newState[index] = 
      if cell is 1 
        if ncount < 2 then 0
        else  
          if ncount is 2 or ncount is 3 then 1 else 0
      else
        if ncount is 3 then 1 else 0
  
  state = newState

$(window.document).ready -> 
  timer = window.setInterval(iterate, 1000)
