local colors = require 'src/colors'
local sceneManager = require 'src/sceneManager'
-- local soundManager = require 'soundManager'

local credits = {}

local BUTTON_WIDTH = 300
local BUTTON_HEIGHT = 40
local BUTTON_RECTANGLE_X = 500

-- local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")

function credits.load( ... )
  -- body
end

function credits.update( dt )
  -- body
end

function credits.draw( ... )
  love.graphics.clear(colors.white)

  love.graphics.setColor(colors.blue)


  love.graphics.print("CREDITS", BUTTON_RECTANGLE_X + 100, 50)


  love.graphics.print("Programming: Felipe Viana (Flash)", BUTTON_RECTANGLE_X + 100, 260)
  love.graphics.print("Art: Vell", BUTTON_RECTANGLE_X + 100, 310)
  love.graphics.print("Sound Design & Composition: James Foss", BUTTON_RECTANGLE_X + 100, 360)


  love.graphics.rectangle(
    "line",
    BUTTON_RECTANGLE_X,
    560,
    BUTTON_WIDTH,
    BUTTON_HEIGHT
  )
  love.graphics.print("BACK", BUTTON_RECTANGLE_X + 100, 560)
end

function credits.keypressed( key )
  if key == 'space' or key == 'return' then
    -- soundManager.play(selectSound)
    sceneManager.changeScene(require 'src/mainMenu')
  end
end

return credits
