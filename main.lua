require 'map-functions'

function love.load()
  loadMap('maps/map2.lua')
end

function love.draw()
  drawMap()
end