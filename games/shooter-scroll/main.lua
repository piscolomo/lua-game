-- Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

Player = {x = 200, y = 710, speed = 150, img = nil}
IsAlive = true
Score = 0

-- Timers
-- We declare these here so we don't have to edit them multiple places
CanShoot = true
CanShootTimerMax = 0.2 
CanShootTimer = CanShootTimerMax
EnemyTimerMax = 2
EnemyTimer = EnemyTimerMax

-- Entity Storage
Bullets = {} -- array of current bullets being drawn and updated
Enemies = {}

function love.load()
  Background = love.graphics.newImage("assets/bg.png")
  Player.img = love.graphics.newImage("assets/plane.png")
  BulletImg = love.graphics.newImage("assets/bullet.png")
  EnemyImg = love.graphics.newImage('assets/enemy.png')
end

function love.update(dt)
  -- Exit Button
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end

  -- Restart Button
  if not IsAlive and love.keyboard.isDown('r') then
    -- Reset Game
    Bullets = {}
    Enemies = {}
    Player.x = 200
    Player.y = 710
    IsAlive = true
    CanShootTimerMax = 0.2 
    CanShootTimer = CanShootTimerMax
    CanShoot = true
    EnemyTimerMax = 2
    EnemyTimer = EnemyTimerMax
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
    local newBullet = {x = Player.x + (Player.img:getWidth()/2), y = Player.y, img = BulletImg}
    table.insert(Bullets, newBullet)
    CanShoot = false
    CanShootTimer = CanShootTimerMax
  end

  -- Bullet Movement
  for i,bullet in ipairs(Bullets) do
    bullet.y = bullet.y - (250*dt)
    if bullet.y < 0 then -- remove bullet if is out of screen
      table.remove(Bullets, i)
    end
  end

  -- Enemies
  EnemyTimer = EnemyTimer - (1 * dt)
  if EnemyTimer < 0 then
    EnemyTimer = EnemyTimerMax
    
    -- Create Enemy
    local randomNumber = math.random(10, love.graphics.getWidth() - 10)
    local newEnemy = {x = randomNumber, y = -10, img = EnemyImg }
    table.insert(Enemies, newEnemy)  
  end

  -- Enemy Movement
  for i,enemy in ipairs(Enemies) do
    enemy.y = enemy.y + (200 * dt)
    if enemy.y > 850 then -- remove enemy if is out of screen
      table.remove(Enemies, i)
    end

    -- Enemy Collision with Bullets
    for j,bullet in ipairs(Bullets) do
      if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
        table.remove(Enemies, i)
        table.remove(Bullets, j)
        Score = Score + 1
      end
    end
    
    -- Enemy Collision with Player
    if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), Player.x, Player.y, Player.img:getWidth(), Player.img:getHeight()) and IsAlive then
      table.remove(Enemies, i)
      IsAlive = false
    end  
  end
end

function love.draw()
  -- Background
  love.graphics.draw(Background)

  -- Drawing Airplane
  if IsAlive then
    love.graphics.draw(Player.img, Player.x, Player.y)
  else
    love.graphics.print('Press R to Restart', love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
  end

  -- Drawing Score
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("SCORE: " .. tostring(Score), 10, 10)

  -- Drawing Bullets
  for i,bullet in ipairs(Bullets) do
    love.graphics.draw(bullet.img, bullet.x, bullet.y)
  end

  -- Drawing Enemies
  for i,enemy in ipairs(Enemies) do
    love.graphics.draw(enemy.img, enemy.x, enemy.y)
  end
end