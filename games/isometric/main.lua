local bump = require "bump"

local world = bump.newWorld()
local cols_len = 0 -- how many collisions are happening

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
local function addBlock(x,y,w,h)
  local block = {x=x,y=y,w=w,h=h}
  blocks[#blocks+1] = block
  world:add(block, x,y,w,h)
end

local function updatePlayer(dt)
end

local function drawBlocks()
  for _,block in ipairs(blocks) do
    drawBox(block, 255,0,0)
  end
end

-- Callbacks
function love:load()
  world:add(player, player.x, player.y, player.w, player.h)

  addBlock(0,       0,     800, 32)
  addBlock(0,      32,      32, 600-32*2)
  addBlock(800-32, 32,      32, 600-32*2)
  addBlock(0,      600-32, 800, 32)

  for i=1,30 do
    addBlock( math.random(100, 600),
              math.random(100, 400),
              math.random(10, 100),
              math.random(10, 100)
    )
  end
end

function love:update(dt)
  cols_len = 0
  --updatePlayer(dt)
end

function love:draw()
  drawBlocks()
  drawPlayer()
end

function love.keypressed(k)
  if k == "escape" then love.event.quit() end
end