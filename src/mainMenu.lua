local sceneManager = require 'src/sceneManager'
local colors = require 'src/colors'

local mainMenu = {}

local selectedButton = 0
local TOTAL_BUTTONS = 3

local BUTTON_WIDTH = 300
local BUTTON_HEIGHT = 40
local BUTTON_RECTANGLE_X = 500

local BUTTON_1_Y = 280

function mainMenu.load()
end

function mainMenu.update( dt )
  -- body
end

function mainMenu.draw( ... )
  love.graphics.clear(colors.white)

  love.graphics.setColor(colors.blue)
  love.graphics.print("Which country is it?", 500, 50)

  if selectedButton == 0 then
    love.graphics.rectangle(
      "line",
      BUTTON_RECTANGLE_X,
      BUTTON_1_Y,
      BUTTON_WIDTH,
      BUTTON_HEIGHT
    )
  end
  love.graphics.print("NEW GAME", BUTTON_RECTANGLE_X + 100, BUTTON_1_Y)


  if selectedButton == 1 then
    love.graphics.rectangle(
      "line",
      BUTTON_RECTANGLE_X,
      BUTTON_1_Y + 50,
      BUTTON_WIDTH,
      BUTTON_HEIGHT
    )
  end
  love.graphics.print("CREDITS", BUTTON_RECTANGLE_X + 100, BUTTON_1_Y + 50)

  if selectedButton == 2 then
    love.graphics.rectangle(
      "line",
      BUTTON_RECTANGLE_X,
      BUTTON_1_Y + 50 * 2,
      BUTTON_WIDTH,
      BUTTON_HEIGHT
    )
  end
  love.graphics.print("EXIT", BUTTON_RECTANGLE_X + 100, BUTTON_1_Y + 50 * 2)
end


function mainMenu.keypressed(key)
  if key == 'space' or key == 'return' then
    -- soundManager.play(selectSound)

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
    -- soundManager.play(changeSound)
  end

  if key == 'down' or key == 's' then
    selectedButton = (selectedButton + 1) % TOTAL_BUTTONS
    -- soundManager.play(changeSound)
  end
end

return mainMenu
