playerImg = nil

function love.load()
  playerImg = love.graphics.newImage("assets/plane.png")
end

function love.update()

end

function love.draw()
  love.graphics.draw(playerImg, 100, 100)
end