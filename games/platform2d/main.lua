local sti = require "sti"
local bump = require "bump"

function love.load()
  love.graphics.setBackgroundColor(225, 153, 0)
  Map = sti.new("maps/map.lua")

  Character = {
    sprites = {
      left = love.graphics.newImage("assets/gripe_run_left.png"),
      right = love.graphics.newImage("assets/gripe_run_right.png")
    },
    x = 50,
    y = 50
  }
  Direction = "right"
  Iteration = 1
  MaxIteration = 8
  Idle = true
  MaxTimer = 0.1
  Timer = MaxTimer

  Quads = {left = {}, right = {}}
  for i=1,8 do
    Quads['left'][i] = love.graphics.newQuad((i-1)*32, 0, 32, 32, 256, 32)
    Quads['right'][i] = love.graphics.newQuad((i-1)*32, 0, 32, 32, 256, 32)
  end
end

function love.update(dt)
  Map:update(dt)

  if not Idle then
    Timer = Timer + dt
    if Timer > 0.2 then
      Timer = MaxTimer
      Iteration = Iteration + 1

      if love.keyboard.isDown('left') then
        Character.x = Character.x - 5
      end

      if love.keyboard.isDown('right') then
        Character.x = Character.x + 5
      end

      if Iteration > MaxIteration then
        Iteration = 1
      end
    end
  end
end

function love.keypressed(key)
  if Quads[key] then
    Direction = key
    Idle = false
  end
end

function love.keyreleased(key)
  if Quads[key] and Direction == key then
    Idle = true
    Iteration = 1
  end
end

function love.draw()
  Map:draw()
  love.graphics.draw(Character.sprites[Direction], Quads[Direction][Iteration], Character.x, Character.y)
end