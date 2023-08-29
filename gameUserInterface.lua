local composer = require("composer")
local widget = require("widget")
local appData = require("data")
-------------------------------------------------------------

local UI = {}

-- CONSTANTS
local BUTTON_WIDTH = appData.buttonWidth    
local BUTTON_HEIGHT = appData.buttonHeight



-- Initialise Variables (used in functions so need to be declared earlier)
local startButton
local isRunning = false

local speedText
speedTextOptions = { text = "x1", fontSize = 28, }



--------------- BUTTON FUNCTIONS ---------------------------|

local function onStartButtonTap(self)
    if isRunning then
        isRunning = false
        startButton:setLabel("Start")
        stopSimulation(gameScene)
    else
        isRunning = true
        startButton:setLabel("Stop")
        startSimulation(gameScene)
    end
    -- Additional code for handling start/stop logic
end


local function onClearButtonTap(self)
    print("Clear Button Pressed")
    resetCells(gameScene)
end

local function onSpeedUpButtonTap(self)
    appData.speed = appData.speed + 1
    if appData.speed > 10 then
        appData.speed = 10  -- Clamp speed at 10
    end 
    speedText.text = "x" .. appData.speed
    print(appData.speed)
end

local function onSpeedDownButtonTap(self)
    appData.speed = appData.speed - 1
    if appData.speed < 1 then
        appData.speed = 1  -- Clamp speed at 0
    end  
    speedText.text = "x" .. appData.speed
    print(appData.speed)
end

local function onSaveButtonTap(self)
    print("Save")
    local transitionOptions = { effect = "fromBottom", time = 500, }
    composer.gotoScene("saveScene", transitionOptions)
end

local function onLoadButtonTap(self)
    print("Load")
    local transitionOptions = { effect = "fromTop", time = 500, }
    composer.gotoScene("loadScene", transitionOptions)
end

---------------------------------------------------------------|




function UI.createUI()
    
    local uiGroup = display.newGroup()
    
    --============== CREATING BUTTONS ====================================|

    -- START/STOP BUTTON --
    startButton = widget.newButton({
        width = appData.buttonWidth ,    
        height = appData.buttonHeight,
        label = "Start",
        fontSize = 16,
        labelColor = { default={1,1,1}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={0.2,0.6,0.2,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onStartButtonTap(self)
        end
    })

   -- CLEAR BUTTON -- 
   local clearButton = widget.newButton({
        width = appData.buttonWidth ,    
        height = appData.buttonHeight,
        label = "Clear",
        fontSize = 16,
        labelColor = { default={1,1,1}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,0,0,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onClearButtonTap(self)
        end
    })

    -- SPEED TEXT
    speedText = display.newText(speedTextOptions)

    -- SPEED UP BUTTON -- 
   local speedUpButton = widget.newButton({
        width = appData.buttonWidth  / 4,    
        height = appData.buttonHeight,
        label = "+",
        fontSize = 32,
        labelColor = { default={0,0,0}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onSpeedUpButtonTap(self)
        end
    })

    -- SPEED DOWN BUTTON -- 
    local speedDownButton = widget.newButton({
        width = appData.buttonWidth  / 4,    
        height = appData.buttonHeight,
        label = "-",
        fontSize = 32,
        labelColor = { default={0,0,0}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onSpeedDownButtonTap(self)
        end
    })

    -- SAVE BUTTON -- 
    local saveIcon = display.newImage("SaveIcon.png")
    saveIcon.width = appData.buttonWidth  / 4
    saveIcon.height = appData.buttonWidth  / 4

    local saveButton = widget.newButton({
        width = appData.buttonWidth  / 4,    
        height = appData.buttonHeight,
        onRelease = function(event)
            onSaveButtonTap(self)
        end
    })

    saveIcon.x = saveButton.width / 2
    saveIcon.y = saveButton.height / 2
    saveButton:insert(saveIcon)


   -- LOAD BUTTON -- 
   local loadIcon = display.newImage("LoadIcon.png")
   loadIcon.width = appData.buttonWidth  / 4
   loadIcon.height = appData.buttonWidth  / 4

   local loadButton = widget.newButton({
       width = appData.buttonWidth  / 4,    
       height = appData.buttonHeight,
       onRelease = function(event)
           onLoadButtonTap(self)
       end
   })

   loadIcon.x = loadButton.width / 2
   loadIcon.y = loadButton.height / 2
   loadButton:insert(loadIcon)    

    --===================================================================|





    -------------- POSITIONING BUTTONS ----------------------------------|

    -- Calculate the bottom position
    local bottomY = display.contentHeight
    
    -- Set the position of the button
    clearButton.x = display.contentWidth / 2
    clearButton.y = bottomY - appData.buttonHeight * 1.25

    startButton.x = display.contentWidth / 2
    startButton.y = bottomY - (appData.buttonHeight * 2.5)

    speedUpButton.x = (display.contentWidth / 2) + appData.buttonWidth  / 2.75
    speedUpButton.y = bottomY - (appData.buttonHeight * 4)

    speedText.x = display.contentWidth / 2
    speedText.y = bottomY - (appData.buttonHeight * 4)

    speedDownButton.x = (display.contentWidth / 2) - appData.buttonWidth  / 2.75
    speedDownButton.y = bottomY - (appData.buttonHeight * 4)

    saveButton.x = appData.buttonWidth  / 4 
    saveButton.y = bottomY - appData.buttonHeight / 1.5
    
    loadButton.x = display.contentWidth - appData.buttonWidth  / 4
    loadButton.y = bottomY - appData.buttonHeight / 1.5

    --------------------------------------------------------------------|
   
    -- Insert Buttons into UIGroup
    uiGroup:insert(startButton) 
    uiGroup:insert(clearButton) 
    uiGroup:insert(speedUpButton) 
    uiGroup:insert(speedDownButton) 
    uiGroup:insert(speedText) 
    uiGroup:insert(saveButton) 
    uiGroup:insert(loadButton) 

    return uiGroup

end


return UI