local sceneManager = require 'src/sceneManager'
local soundManager = require 'src/soundManager'
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

local LANE_0_X = 50
local LANE_DISTANCE = 200

local round
globalScore = 0
globalTime = 0

local correctLane
local currentTip

local playerAnimation

local function random(a, b)
  if not a then a, b = 0, 1 end
  if not b then b = 0 end

  return math.floor(a + math.random() * (b - a))
end

local function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, 160 - height, height do
        for x = 0, 160 - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
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

  correctLane = random(0, 5)
  currentTip = random(1, 11)

  playerAnimation = newAnimation(playerImage, 32, 32, 1)
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
      soundManager.play(rightCountrySound)
    else
      globalScore = globalScore - 10
      soundManager.play(wrongCountrySound)
    end

    boxLane = currentLane

    correctLane = random(0, 5)
    currentTip = random(1, 11)
  end


  globalTime = globalTime + dt

  if round > 10 then
    sceneManager.changeScene(require 'src/playAgain')
  end

  playerAnimation.currentTime = playerAnimation.currentTime + dt
  if playerAnimation.currentTime >= playerAnimation.duration then
      playerAnimation.currentTime = playerAnimation.currentTime - playerAnimation.duration
  end

end

function game.draw( ... )
  love.graphics.clear(colors.white)

  love.graphics.setColor({1, 1, 1})
  love.graphics.draw(brazilFlag, 45 + LANE_0_X - 25, 10+10, 0, 0.2, 0.2)
  love.graphics.draw(latviaFlag, 50 + LANE_0_X - 40 + LANE_DISTANCE, 10 + 20, 0, 0.25, 0.25)
  love.graphics.draw(sudanFlag, 50 + LANE_0_X - 30 + LANE_DISTANCE * 2, 10 + 10, 0, 0.2, 0.2)
  love.graphics.draw(italyFlag, 50 + LANE_0_X - 25 + LANE_DISTANCE * 3, 10 + 20, 0, 0.3, 0.3)
  love.graphics.draw(mexicoFlag, 50 + LANE_0_X - 25 + LANE_DISTANCE * 4, 10 + 20, 0, 0.3, 0.3)

  love.graphics.setColor(colors.blue)
  for i = 1, TOTAL_LANES do
    love.graphics.print(tostring(countries[i]), LANE_0_X + LANE_DISTANCE * (i - 1) + 50, 100)
    love.graphics.line(
      LANE_0_X + LANE_DISTANCE * (i - 1) - 25,
      0,
      LANE_0_X + LANE_DISTANCE * (i - 1) - 25,
      1300
    )
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

  local spriteNum = math.floor(playerAnimation.currentTime / playerAnimation.duration * #playerAnimation.quads) + 1
  love.graphics.draw(playerAnimation.spriteSheet, playerAnimation.quads[spriteNum], playerX-15 + 50, PLAYER_Y-25, 0, 2)


  love.graphics.setColor(colors.yellow)
  love.graphics.rectangle(
    'fill',
    35,
    300,
    935,
    200
  )
  love.graphics.setColor(colors.darkBlue)
  love.graphics.print('Which country is it?', 350, 350)

  local currentPhrase = facts[countries[correctLane + 1]][currentTip]
  love.graphics.print(currentPhrase, 350 - string.len(currentPhrase) * 2, 400)

  love.graphics.setColor({1, 1, 1})
  love.graphics.draw(
    boxImage,
    boxX + 25,
    boxY,
    0,
    3,
    3
  )
end

function game.keypressed( key )
  if key == 'd' or key == 'right' then
    currentLane = (currentLane + 1) % TOTAL_LANES
    soundManager.play(changeLaneSound)
  end
  if key == 'a' or key == 'left' then
    currentLane = (currentLane - 1 + TOTAL_LANES) % TOTAL_LANES
    soundManager.play(changeLaneSound)
  end

  if key == 'space' then
    boxSpeed = 600
  end


  if key == 'escape' then
    love.event.quit(0)
  end
end

return game
