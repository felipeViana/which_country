
local mainMenu = {}

function mainMenu.load()
end

function mainMenu.update( dt )
  -- body
end

function mainMenu.draw( ... )
  love.graphics.print(facts['Brazil'][1])
end

function mainMenu.keypressed( key )
  if key == 'escape' then
    love.event.quit(0)
  end
end

return mainMenu
