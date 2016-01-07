Player = {x = 200, y = 710, speed = 150, img = nil}

function love.load()
  Player.img = love.graphics.newImage("assets/plane.png")
end

function love.update(dt)
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end

  if love.keyboard.isDown('left', 'a') then
    if Player.x > 0 then -- ensure plane is always in window
      Player.x = Player.x - (Player.speed*dt)
    end
  elseif love.keyboard.isDown('right', 'd') then
    if Player.x < (love.graphics.getWidth() - Player.img:getWidth()) then
      Player.x = Player.x + (Player.speed*dt)
    end
  end
end

function love.draw()
  love.graphics.draw(Player.img, Player.x, Player.y)
end