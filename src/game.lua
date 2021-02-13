local sceneManager = require 'src/sceneManager'
local colors = require 'src/colors'

local game = {}

local playerX, currentLane
local PLAYER_Y = 600
local PLAYER_WIDTH = 32
local PLAYER_HEIGHT = 32

local TOTAL_LANES = 5

local boxX, boxY, boxSpeed, boxLane
local BOX_WIDTH = 50
local BOX_HEIGHT = 50

local LANE_0_X = 100
local LANE_DISTANCE = 200

local round
local score
local time

function game.load( ... )
  playerX = 100
  currentLane = 0

  boxX = 100
  boxY = 550
  boxSpeed = 0
  boxLane = 0

  round = 1
  score = 0
  time = 0
end

function game.update( dt )
  -- 200, 400, 600, 800, 1000
  playerX = currentLane * LANE_DISTANCE + LANE_0_X
  if boxSpeed == 0 then
    boxX = playerX - PLAYER_WIDTH / 4
    boxLane = currentLane
  end

  boxY = boxY - boxSpeed * dt

  if boxY < 0 then
    boxY = 550
    boxSpeed = 0
    boxX = playerX - PLAYER_WIDTH / 4
    boxLane = currentLane

    -- next round
  end


  time = time + dt
end

function game.draw( ... )
  love.graphics.clear(colors.white)

  love.graphics.setColor(colors.blue)
  love.graphics.print('Which country is it?', 400, 350)
  love.graphics.print(facts['Brazil'][1], 300, 400)

  for i = 1, TOTAL_LANES do
    love.graphics.print(tostring(countries[i]), LANE_0_X + LANE_DISTANCE * (i - 1), 100)
  end

  love.graphics.setColor(colors.darkBlue)
  love.graphics.rectangle(
    'fill',
    1000,
    0,
    400,
    800
  )

  love.graphics.setColor(colors.yellow)
  love.graphics.print('Round: ' .. round .. '/10', 1050, 100)
  love.graphics.print('Score: ' .. score, 1050, 150)
  love.graphics.print('Time: ' .. time, 1050, 200)

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
  if key == 'a' or key == 'left' then
    currentLane = (currentLane - 1 + TOTAL_LANES) % TOTAL_LANES
  end

  if key == 'space' then
    boxSpeed = 500
  end


  if key == 'escape' then
    love.event.quit(0)
  end
end

return game
