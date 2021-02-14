local sceneManager = require 'src/sceneManager'
local soundManager = require 'src/soundManager'
local colors = require 'src/colors'

local mainMenu = {}

local selectedButton = 0
local TOTAL_BUTTONS = 3

local BUTTON_WIDTH = 300
local BUTTON_HEIGHT = 80
local BUTTON_RECTANGLE_X = 475

local BUTTON_1_Y = 280

function mainMenu.load()
end

function mainMenu.update( dt )
  -- body
end

function mainMenu.draw( ... )
  love.graphics.clear(colors.white)

  love.graphics.setColor(colors.blue)
  love.graphics.setFont(bigFont)
  love.graphics.print("Which country is it?", 475, 50)

  if selectedButton == 0 then
    love.graphics.rectangle(
      "line",
      BUTTON_RECTANGLE_X,
      BUTTON_1_Y - 25,
      BUTTON_WIDTH,
      BUTTON_HEIGHT
    )
  end
  love.graphics.print("NEW GAME", BUTTON_RECTANGLE_X + 75, BUTTON_1_Y)


  if selectedButton == 1 then
    love.graphics.rectangle(
      "line",
      BUTTON_RECTANGLE_X,
      BUTTON_1_Y + 100 - 25,
      BUTTON_WIDTH,
      BUTTON_HEIGHT
    )
  end
  love.graphics.print("CREDITS", BUTTON_RECTANGLE_X + 75, BUTTON_1_Y + 100)

  if selectedButton == 2 then
    love.graphics.rectangle(
      "line",
      BUTTON_RECTANGLE_X,
      BUTTON_1_Y + 100 * 2 - 25,
      BUTTON_WIDTH,
      BUTTON_HEIGHT
    )
  end
  love.graphics.print("EXIT", BUTTON_RECTANGLE_X + 75, BUTTON_1_Y + 100 * 2)
end


function mainMenu.keypressed(key)
  if key == 'space' or key == 'return' then
    soundManager.play(selectSound)

    if selectedButton == 0 then
      sceneManager.changeScene(require 'src/game')
    elseif selectedButton == 1 then
      sceneManager.changeScene(require 'src/credits')
    elseif selectedButton == 2 then
      love.event.quit(0)
    end
  end

  if key == 'up' or key == 'w' then
    selectedButton = (selectedButton + TOTAL_BUTTONS - 1) % TOTAL_BUTTONS
    soundManager.play(changeSound)
  end

  if key == 'down' or key == 's' then
    selectedButton = (selectedButton + 1) % TOTAL_BUTTONS
    soundManager.play(changeSound)
  end
end

return mainMenu
