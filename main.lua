function love.load()
  MyGlobalTable = {}
  -- MyGlobalTable[1] = 'My first element'
  -- MyGlobalTable[2] = 'My second element'
  MyGlobalTable = { 'My first element', 'My second element' }
  -- Using Subtables
  -- MyGlobalTable[1] = {}
  -- MyGlobalTable[1][1] = 'Stuff inside a sub-table'
  -- MyGlobalTable[1][2] = 'More stuff inside a sub-table'
end
function love.draw()
  love.graphics.print(MyGlobalTable,100,100) -- prints 'My first element' on 100,100
end