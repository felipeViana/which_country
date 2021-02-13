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
globalScore = 0
globalTime = 0

local correctLane
local currentTip

local function getNearestInteger( value )
  local smallerInt = value - value % 1
  local BiggerInt = (value + 1) - value % 1

  if BiggerInt - value > value - smallerInt then
    return smallerInt
  else
    return BiggerInt
  end
end

local function random(a, b)
  if not a then a, b = 0, 1 end
  if not b then b = 0 end
  return getNearestInteger(a + math.random() * (b - a))
end

function game.load( ... )
  playerX = 100
  currentLane = 0

  boxX = 100
  boxY = 550
  boxSpeed = 0
  boxLane = 0

  round = 1
  globalScore = 0
  globalTime = 0

  correctLane = random(0, 4)
  currentTip = random(1, 10)
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

    -- next round
    round = round + 1

    if boxLane == correctLane then
      globalScore = globalScore + 10
    else
      globalScore = globalScore - 10
    end

    boxLane = currentLane

    correctLane = random(0, 4)
    currentTip = random(1, 10)
  end


  globalTime = globalTime + dt

  if round > 10 then
    sceneManager.changeScene(require 'src/playAgain')
  end
end

function game.draw( ... )
  love.graphics.clear(colors.white)

  love.graphics.setColor({1, 1, 1})
  love.graphics.draw(brazilFlag, LANE_0_X - 25, 10+10, 0, 0.2, 0.2)
  love.graphics.draw(latviaFlag, LANE_0_X - 25 + LANE_DISTANCE, 10 + 20, 0, 0.25, 0.25)
  love.graphics.draw(sudanFlag, LANE_0_X - 25 + LANE_DISTANCE * 2, 10 + 10, 0, 0.2, 0.2)
  love.graphics.draw(italyFlag, LANE_0_X - 25 + LANE_DISTANCE * 3, 10 + 20, 0, 0.3, 0.3)
  love.graphics.draw(mexicoFlag, LANE_0_X - 25 + LANE_DISTANCE * 4, 10 + 20, 0, 0.3, 0.3)

  love.graphics.setColor(colors.blue)
  love.graphics.print('Which country is it?', 400, 350)

  -- love.graphics.print(correctLane, 100, 300)
  -- love.graphics.print(currentTip, 100, 350)
  love.graphics.print(facts[countries[correctLane + 1]][currentTip], 50, 400)

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
  love.graphics.print('round: ' .. round .. '/10', 1050, 100)
  love.graphics.print('score: ' .. globalScore, 1050, 150)
  love.graphics.print('time: ' .. globalTime, 1050, 200)

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
