debug = true

Player = {x = 200, y = 710, speed = 150, img = nil}

-- Timers
-- We declare these here so we don't have to edit them multiple places
CanShoot = true
CanShootTimerMax = 0.2 
CanShootTimer = CanShootTimerMax

-- Image Storage
--bulletImg = nil

-- Entity Storage
Bullets = {} -- array of current bullets being drawn and updated

function love.load()
  Player.img = love.graphics.newImage("assets/plane.png")
  BulletImg = love.graphics.newImage("assets/bullet.png")
end

function love.update(dt)
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end

  -- Airplane Movement
  if love.keyboard.isDown('left', 'a') then
    if Player.x > 0 then -- ensure plane is always in window
      Player.x = Player.x - (Player.speed*dt)
    end
  elseif love.keyboard.isDown('right', 'd') then
    if Player.x < (love.graphics.getWidth() - Player.img:getWidth()) then
      Player.x = Player.x + (Player.speed*dt)
    end
  end

  -- Airplane Shoot
  
  -- Time out how far apart our shots can be.
  CanShootTimer = CanShootTimer - (1 * dt)
  if CanShootTimer < 0 then
    CanShoot = true
  end

  -- Create Bullet
  if love.keyboard.isDown(' ','ctrl','lctrl','rctrl') and CanShoot then
    newBullet = {x = Player.x + (Player.img:getWidth()/2), y = Player.y, img = BulletImg}
    table.insert(Bullets, newBullet)
    CanShoot = false
    CanShootTimer = CanShootTimerMax
  end

  -- Bullet Movement
  for i,bullet in ipairs(Bullets) do
    bullet.y = bullet.y - (250*dt)
    if bullet.y < 0 then
      table.remove(Bullets, i)
    end
  end
end

function love.draw()
  -- Drawing Airplane
  love.graphics.draw(Player.img, Player.x, Player.y)

  -- Drawing Bullets
  for i,bullet in ipairs(Bullets) do
    love.graphics.draw(bullet.img, bullet.x, bullet.y)
  end
end