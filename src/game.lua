local sceneManager = require 'src/sceneManager'
local colors = require 'src/colors'

local game = {}

local playerX, currentLane
local PLAYER_Y = 600
local PLAYER_WIDTH = 32
local PLAYER_HEIGHT = 32

local TOTAL_LANES = 5

local boxX, boxY, boxSpeed
local BOX_WIDTH = 50
local BOX_HEIGHT = 50

function game.load( ... )
  playerX = 100
  currentLane = 0

  boxX = 100
  boxY = 550
  boxSpeed = 0
end

function game.update( dt )
  -- 200, 400, 600, 800, 1000
  playerX = currentLane * 200 + 200
  boxX = playerX - PLAYER_WIDTH / 4
end

function game.draw( ... )
  love.graphics.clear(colors.white)

  love.graphics.setColor(colors.blue)
  love.graphics.print(facts['Brazil'][1], 400, 300)

  love.graphics.rectangle(
    'fill',
    playerX,
    PLAYER_Y,
    PLAYER_WIDTH,
    PLAYER_HEIGHT
  )

  love.graphics.setColor(colors.red)
  love.graphics.rectangle(
    'fill',
    boxX,
    boxY,
    BOX_WIDTH,
    BOX_HEIGHT
  )
end

function game.keypressed( key )
  if key == 'd' or key == 'right' then
    currentLane = (currentLane + 1) % TOTAL_LANES
  end


  if key == 'escape' then
    love.event.quit(0)
  end
end

return game
