local composer = require("composer")
local widget = require("widget")
local speedModule = require("simulationSpeed")
-------------------------------------------------------------

local UI = {}

-- CONSTANTS
local BUTTON_WIDTH = 100    
local BUTTON_HEIGHT = 30



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
    speedModule.speed = speedModule.speed + 1
    if speedModule.speed > 10 then
        speedModule.speed = 10  -- Clamp speed at 10
    end 
    speedText.text = "x" .. speedModule.speed
    print(speedModule.speed)
end

local function onSpeedDownButtonTap(self)
    speedModule.speed = speedModule.speed - 1
    if speedModule.speed < 1 then
        speedModule.speed = 1  -- Clamp speed at 0
    end  
    speedText.text = "x" .. speedModule.speed
    print(speedModule.speed)
end

local function onSaveButtonTap(self)
    print("Save")
end

local function onLoadButtonTap(self)
    print("Load")
end

---------------------------------------------------------------|




function UI.createUI(sceneGroup)
    
    local uiGroup = display.newGroup()
    
    --============== CREATING BUTTONS ====================================|

    -- START/STOP BUTTON --
    startButton = widget.newButton({
        width = BUTTON_WIDTH,    
        height = BUTTON_HEIGHT,
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
        width = BUTTON_WIDTH,    
        height = BUTTON_HEIGHT,
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
        width = BUTTON_WIDTH / 4,    
        height = BUTTON_HEIGHT,
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
        width = BUTTON_WIDTH / 4,    
        height = BUTTON_HEIGHT,
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
    saveIcon.width = BUTTON_WIDTH / 4
    saveIcon.height = BUTTON_WIDTH / 4

    local saveButton = widget.newButton({
        width = BUTTON_WIDTH / 4,    
        height = BUTTON_HEIGHT,
        onRelease = function(event)
            onSaveButtonTap(self)
        end
    })

    saveIcon.x = saveButton.width / 2
    saveIcon.y = saveButton.height / 2
    saveButton:insert(saveIcon)


   -- LOAD BUTTON -- 
   local loadIcon = display.newImage("LoadIcon.png")
   loadIcon.width = BUTTON_WIDTH / 4
   loadIcon.height = BUTTON_WIDTH / 4

   local loadButton = widget.newButton({
       width = BUTTON_WIDTH / 4,    
       height = BUTTON_HEIGHT,
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
    clearButton.y = bottomY - BUTTON_HEIGHT * 1.25

    startButton.x = display.contentWidth / 2
    startButton.y = bottomY - (BUTTON_HEIGHT * 2.5)

    speedUpButton.x = (display.contentWidth / 2) + BUTTON_WIDTH / 2.75
    speedUpButton.y = bottomY - (BUTTON_HEIGHT * 4)

    speedText.x = display.contentWidth / 2
    speedText.y = bottomY - (BUTTON_HEIGHT * 4)

    speedDownButton.x = (display.contentWidth / 2) - BUTTON_WIDTH / 2.75
    speedDownButton.y = bottomY - (BUTTON_HEIGHT * 4)

    saveButton.x = BUTTON_WIDTH / 4 
    saveButton.y = bottomY - BUTTON_HEIGHT / 1.5
    
    loadButton.x = display.contentWidth - BUTTON_WIDTH / 4
    loadButton.y = bottomY - BUTTON_HEIGHT / 1.5

    --------------------------------------------------------------------|
   
    sceneGroup:insert(uiGroup) -- Insert the uiGroup into the sceneGroup

end


return UI