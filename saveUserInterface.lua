local composer = require("composer")
local widget = require("widget")
-------------------------------------------------------------

local UI = {}

-- CONSTANTS
local BUTTON_WIDTH = 100    
local BUTTON_HEIGHT = 30


local oneDigitText
local tenDigitText
local hundredDigitText
digitTextOptions = { text = "0", fontSize = 28, }


--------------- BUTTON FUNCTIONS ---------------------------|

local function onLoadButtonTap(self)
    print("Load")
    local transitionOptions = { effect = "fade", time = 500, }
    composer.gotoScene("gameScene", transitionOptions)
end


local function onCloseButtonTap(self)
    print("Close")
    local transitionOptions = { effect = "slideDown", time = 500, }
    composer.gotoScene("gameScene", transitionOptions)
end


---------------------------------------------------------------|




function UI.createUI()
    
    local uiGroup = display.newGroup()
    
    --============== CREATING BUTTONS ====================================|

    -- LOAD BUTTON --
    loadButton = widget.newButton({
        width = BUTTON_WIDTH,    
        height = BUTTON_HEIGHT,
        label = "Save",
        fontSize = 16,
        labelColor = { default={1,1,1}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={0.2,0.6,0.2,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onLoadButtonTap(self)
        end
    })

    -- CLOSE BUTTON -- 
   local closeButton = widget.newButton({
        width = BUTTON_WIDTH,    
        height = BUTTON_HEIGHT,
        label = "Close",
        fontSize = 16,
        labelColor = { default={1,1,1}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,0,0,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onCloseButtonTap(self)
        end
    })



    -- ONE DIGIT TEXT
    oneDigitText = display.newText(digitTextOptions)

    -- UP BUTTON -- 
    local oneDigitUpButton = widget.newButton({
        width = BUTTON_WIDTH / 6,    
        height = BUTTON_HEIGHT / 2,
        label = "▲",
        fontSize = 12,
        labelColor = { default={0,0,0}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onSpeedUpButtonTap(self)
        end
    })
    
    -- DOWN BUTTON -- 
    local oneDigitDownButton = widget.newButton({
        width = BUTTON_WIDTH / 6,    
        height = BUTTON_HEIGHT / 2,
        label = "▼",
        fontSize = 12,
        labelColor = { default={0,0,0}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onSpeedDownButtonTap(self)
        end
    })

    --===================================================================|



    -------------- POSITIONING BUTTONS ----------------------------------|

    -- Calculate the bottom position
    local bottomY = display.contentHeight
    
    -- Set the position of the button
    closeButton.x = display.contentWidth / 2
    closeButton.y = bottomY - BUTTON_HEIGHT * 1.25

    loadButton.x = display.contentWidth / 2
    loadButton.y = bottomY - (BUTTON_HEIGHT * 2.5)

    -- Position One Digit Text & Buttons
    oneDigitUpButton.x = (display.contentWidth / 2) - BUTTON_WIDTH / 2.75
    oneDigitUpButton.y = (bottomY - (BUTTON_HEIGHT * 4)) - BUTTON_HEIGHT / 1.5
    oneDigitText.x = (display.contentWidth / 2) - BUTTON_WIDTH / 2.75
    oneDigitText.y = bottomY - (BUTTON_HEIGHT * 4)
    oneDigitDownButton.x = (display.contentWidth / 2) - BUTTON_WIDTH / 2.75
    oneDigitDownButton.y = (bottomY - (BUTTON_HEIGHT * 4)) + BUTTON_HEIGHT / 1.5

    

    --------------------------------------------------------------------|
   


    -- Insert Buttons into UIGroup
    uiGroup:insert(loadButton) 
    uiGroup:insert(closeButton)
    uiGroup:insert(oneDigitText) 
    uiGroup:insert(oneDigitUpButton) 
    uiGroup:insert(oneDigitDownButton) 

    return uiGroup

end





return UI