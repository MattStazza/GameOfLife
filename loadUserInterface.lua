local composer = require("composer")
local widget = require("widget")
local appData = require("data")
-------------------------------------------------------------

local UI = {}

local count = 0

local currentFileNumberText
currentfileNumberTextOptions = { text = count .. " / ", fontSize = 28, }
local totalFileNumberText
totalfileNumberTextOptions = { text = tostring(fileID), fontSize = 28, }

--------------- BUTTON FUNCTIONS ---------------------------|

local function onLoadButtonTap(self)
    print("Load")
    local transitionOptions = { effect = "fade", time = 500, }
    composer.gotoScene("gameScene", transitionOptions)
end

local function onCloseButtonTap(self)
    print("Close")
    local transitionOptions = { effect = "slideUp", time = 500, }
    composer.gotoScene("gameScene", transitionOptions)
end

local function onLeftButtonTap(self)
    print("Left")
    loadSpecificGameboard(loadScene)
end

local function onRightButtonTap(self)
    print("Right")
    loadSpecificGameboard(loadScene)
end

---------------------------------------------------------------|



function UI.createUI()
    
    local uiGroup = display.newGroup()
    
    --============== CREATING BUTTONS ====================================|

    -- LOAD BUTTON --
    loadButton = widget.newButton({
        width = appData.buttonWidth  ,    
        height = appData.buttonHeight,
        label = "Load",
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
        width = appData.buttonWidth  ,    
        height = appData.buttonHeight,
        label = "Close",
        fontSize = 16,
        labelColor = { default={1,1,1}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,0,0,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onCloseButtonTap(self)
        end
    })


    -------------------------------------------------------------------

    
    -- LEFT BUTTON -- 
    local leftIcon = display.newImage("leftIcon.png")
    leftIcon.width = appData.buttonWidth / 4
    leftIcon.height = appData.buttonWidth / 3

    local leftButton = widget.newButton({
        width = appData.buttonWidth / 4 ,    
        height = appData.buttonHeight,
        onRelease = function(event)
            onLeftButtonTap(self)
        end
    })

    leftIcon.x = leftButton.width / 2
    leftIcon.y = leftButton.height / 2
    leftButton:insert(leftIcon)



    -- RIGHT BUTTON -- 
    local rightIcon = display.newImage("rightIcon.png")
    rightIcon.width = appData.buttonWidth  / 4
    rightIcon.height = appData.buttonWidth  / 3

    local rightButton = widget.newButton({
        width = appData.buttonWidth / 4  ,    
        height = appData.buttonHeight,
        onRelease = function(event)
            onRightButtonTap(self)
        end
    })

    rightIcon.x = rightButton.width / 2
    rightIcon.y = rightButton.height / 2
    rightButton:insert(rightIcon)


    -------------------------------------------------------------------


    -- FILE INDICATOR TEXT
    currentFileNumberText = display.newText(currentfileNumberTextOptions)
    totalFileNumberText = display.newText(totalfileNumberTextOptions)


    --===================================================================|



    -------------- POSITIONING BUTTONS ----------------------------------|

    -- Calculate the bottom position
    local bottomY = display.contentHeight
    
    -- Set the position of the button
    closeButton.x = display.contentWidth / 2
    closeButton.y = bottomY - appData.buttonHeight * 1.25

    loadButton.x = display.contentWidth / 2
    loadButton.y = bottomY - (appData.buttonHeight * 2.5)

    leftButton.x = 0 + (appData.buttonWidth / 4)
    leftButton.y = display.contentHeight / 2
    
    rightButton.x = display.contentWidth - (appData.buttonWidth / 4)
    rightButton.y = display.contentHeight / 2

    currentFileNumberText.x = display.contentWidth / 2.1
    currentFileNumberText.y = bottomY - (appData.buttonHeight * 4)

    totalFileNumberText.x = display.contentWidth / 1.8
    totalFileNumberText.y = bottomY - (appData.buttonHeight * 4)

    --------------------------------------------------------------------|
   


    -- Insert Buttons into UIGroup
    uiGroup:insert(loadButton) 
    uiGroup:insert(closeButton)
    uiGroup:insert(leftButton) 
    uiGroup:insert(rightButton)
    uiGroup:insert(currentFileNumberText)
    uiGroup:insert(totalFileNumberText)

    return uiGroup

end





return UI