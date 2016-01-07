function love.load()
  Messages = { 'My first element', 'My second element' }
end

function love.draw()
  -- Using # returns the length of the table
  for i=1,#Messages do
    love.graphics.print(Messages[i], 100, 50 * i)
  end
end