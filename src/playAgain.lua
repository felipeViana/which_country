local sceneManager = require 'src/sceneManager'
local colors = require 'src/colors'

local playAgain = {}

function playAgain.load( ... )
  -- body
end

function playAgain.update( dt )
  -- body
end

function playAgain.draw( ... )
  love.graphics.clear(colors.white)

  love.graphics.setColor(colors.blue)

  love.graphics.print('Results', 600, 100)

  love.graphics.print('Score: ' .. globalScore, 500, 200)
  love.graphics.print('Time used: ' .. globalTime, 500, 250)

  love.graphics.print('Press ENTER to play again', 500, 500)
end

function playAgain.keypressed( key )
  if key == 'return' then
    sceneManager.changeScene(require 'src/game')
  end

  if key == 'escape' then
    love.event.quit(0)
  end
end

return playAgain
