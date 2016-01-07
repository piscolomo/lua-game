require 'map-functions'

function love.load()

  local tileString = [[
^#######################^
^                    *  ^
^  *                    ^
^              *        ^
^                       ^
^    ##  ^##  ^## ^ ^   ^
^   ^  ^ ^  ^ ^   ^ ^   ^
^   ^  ^ ^ *# ^   ^ ^   ^
^   ^  ^ ^##  ^## # #   ^
^   ^  ^ ^  ^ ^    ^  * ^
^ * ^  ^ ^  ^ ^    ^    ^
^   #  # ^* # ^  * ^    ^
^    ##  ###  ###  #    ^
^                       ^
^   *****************   ^
^                       ^
^  *                  * ^
#########################
]]

  local quadInfo = {
    { ' ', 0,  0  }, -- grass 
    { '#', 32,  0 }, -- box
    { '*', 0, 32  }, -- flowers
    { '^', 32, 32 }  -- boxTop
  }

  loadMap(32,32,'images/countryside.png',tileString,quadInfo)
end

function love.draw()
  drawMap()
end