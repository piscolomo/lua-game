require 'map-functions'

function love.load()
  loadMap('maps/map1.lua')
end

function love.draw()
  drawMap()
end