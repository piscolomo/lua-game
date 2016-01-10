local sti = require "sti"
local bump = require "bump"
local inspect = require "inspect"

local world = bump.newWorld(16)
local blocks = {}

function love.load()
  love.graphics.setBackgroundColor(225, 153, 0)
  Map = sti.new("maps/map.lua")

  local collide_tiles = Map.layers[1].data

  for tileY,rowTiles in ipairs(collide_tiles) do
    for tileX=1,Map.width do
      local tile = rowTiles[tileX]
      if tile then
        local block = {
          id = tile.id,
          gid = tile.gid,
          x = (tileX * 16) - tile.width,
          y = (tileY * 16) - tile.height,
          width = tile.width,
          height = tile.height
        }
        blocks[#blocks+1] = block
        world:add(block, block.x, block.y, block.width, block.height)
      end
    end
  end

  Character = {
    sprites = {
      left = love.graphics.newImage("assets/gripe_run_left.png"),
      right = love.graphics.newImage("assets/gripe_run_right.png")
    },
    x = 20,
    y = 300,
    speed = 350
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

  world:add(Character, Character.x, Character.y, 32, 32)
end

function love.update(dt)
  Map:update(dt)
  local dx = 0

  if not Idle then
    Timer = Timer + dt
    if Timer > 0.2 then
      Timer = MaxTimer
      Iteration = Iteration + 1

      if love.keyboard.isDown('left') then
        dx = -Character.speed * dt
      end

      if love.keyboard.isDown('right') then
        dx = Character.speed * dt
      end

      if Iteration > MaxIteration then
        Iteration = 1
      end

      if dx ~= 0 then
        Character.x, Character.y, cols, cols_len = world:move(Character, Character.x + dx, Character.y)
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