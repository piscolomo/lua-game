local bump = require "bump"

local world = bump.newWorld()

local player = { x = 50, y = 50, w = 20, h = 20, speed = 80 }
local blocks = {}

-- Helpers
local function drawBox(box, r,g,b)
  love.graphics.setColor(r,g,b,70)
  love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
  love.graphics.setColor(r,g,b)
  love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
end

local function drawPlayer()
  drawBox(player, 0, 255, 0)
end


-- Functions
local function updatePlayer(dt)
  
end

-- Callbacks
function love:load()
  world:add(player, player.x, player.y, player.w, player.h)
end

function love:update(dt)
  updatePlayer(dt)
end

function love:draw()
  drawPlayer()
end