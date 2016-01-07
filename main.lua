function love.load()
  -- This is a Subtable
  MyGlobalTable = { 
    { 'Stuff inside a sub-table', 'More stuff inside a sub-table' },
    { 'Stuff inside the second sub-table', 'Even more stuff' }
  }
end

function love.draw()
  -- inpairs is helpful for iterate in table that has subtables
  for i,subtable in ipairs(MyGlobalTable) do
    for j,elem in ipairs(subtable) do
      love.graphics.print(elem, 100 * i, 50 * j)
    end
  end
end

--ipairs will not iterate over the values that aren’t indexed with a number, 
--and will stop on the first nil it finds. If you need to iterate over a table 
--with non-numerical values, or with nil values in some cells, use pairs instead of ipairs.