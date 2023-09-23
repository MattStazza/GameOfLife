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
speedTextOptions = { text = "x1", fontSize = 24, font = "TR-909.ttf" }



--------------- BUTTON FUNCTIONS ---------------------------|
local function resetGameUI()
    resetData(appData)
    resetCounter()
    pauseIcon.alpha = 0
    playIcon.alpha = 1
    isRunning = false
end



local function onStartButtonTap(self)
    if isRunning then
        isRunning = false
        pauseIcon.alpha = 0
        playIcon.alpha = 1
        pauseSimulation(gameScene)
    else
        isRunning = true
        pauseIcon.alpha = 1
        playIcon.alpha = 0
        startSimulation(gameScene)
    end
end

local function onResetButtonTap(self)
    print("Reset")
    resetGameUI()
    composer.gotoScene("gameScene") -- Reload Scene
end

local function onSpeedUpButtonTap(self)
    appData.speed = appData.speed + 1
    if appData.speed > 10 then
        appData.speed = 10  -- Clamp speed at 10
    end 
    speedText.text = "x" .. appData.speed
    print("Speed: " .. appData.speed)
end

local function onSpeedDownButtonTap(self)
    appData.speed = appData.speed - 1
    if appData.speed < 1 then
        appData.speed = 1  -- Clamp speed at 0
    end  
    speedText.text = "x" .. appData.speed
    print("Speed: " .. appData.speed)
end

local function onSaveButtonTap(self)
    resetGameUI()
    local transitionOptions = { effect = "fromBottom", time = 750, }
    composer.gotoScene("saveScene", transitionOptions)
end

local function onLoadButtonTap(self)
    resetGameUI()
    local transitionOptions = { effect = "fromTop", time = 750, }
    composer.gotoScene("loadScene", transitionOptions)
end

---------------------------------------------------------------|




function UI.createUI()
    
    local uiGroup = display.newGroup()
    
    --============== CREATING BUTTONS ====================================|

    -- PLAY / PAUSE BUTTON --

    -- Create Icons
    playIcon = display.newImage("icons/PlayIcon.png")
    playIcon.width = appData.buttonWidth / 2
    playIcon.height = appData.buttonWidth / 2
    playIcon:setFillColor(unpack(appData.iconColor))
    pauseIcon = display.newImage("icons/PauseIcon.png")
    pauseIcon.width = appData.buttonWidth / 2
    pauseIcon.height = appData.buttonWidth / 2
    pauseIcon:setFillColor(unpack(appData.iconColor))

    -- Create Button
    startButton = widget.newButton({
        width = appData.buttonWidth / 2,    
        height = appData.buttonHeight * 2,
        onRelease = function(event)
            onStartButtonTap(self)
        end
    })
    
    -- Position Icons
    playIcon.x = startButton.width / 2
    playIcon.y = startButton.height / 2
    startButton:insert(playIcon)
    pauseIcon.x = startButton.width / 2
    pauseIcon.y = startButton.height / 2
    startButton:insert(pauseIcon)

    pauseIcon.alpha = 0



   -- RESET BUTTON -- 
   local resetButton = widget.newButton({
        width = appData.buttonWidth ,    
        height = appData.buttonHeight,
        label = "RESET",
        font = "TR-909.ttf",
        fontSize = 16,
        labelColor = { default={0,0,0}, over={0,0,0} },
        shape = "roundedRect",
        fillColor = { default={1, 0.5, 1}, over={0.5, 0.5, 0.5} },
        onRelease = function(event)
            onResetButtonTap(self)
        end
    })

    -- SPEED TEXT
    speedText = display.newText(speedTextOptions)

    -- SPEED UP BUTTON -- 
   local speedUpButton = widget.newButton({
        width = appData.buttonWidth / 4,    
        height = appData.buttonHeight / 1.25,
        label = "+",
        fontSize = 32,
        labelColor = { default={0,0,0}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.5,0.5,0.5, 1} },
        onRelease = function(event)
            onSpeedUpButtonTap(self)
        end
    })

    -- SPEED DOWN BUTTON -- 
    local speedDownButton = widget.newButton({
        width = appData.buttonWidth / 4,    
        height = appData.buttonHeight / 1.25,
        label = "-",
        fontSize = 32,
        labelColor = { default={0,0,0}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.5,0.5,0.5, 1} },
        onRelease = function(event)
            onSpeedDownButtonTap(self)
        end
    })

    -- SAVE BUTTON -- 
    local saveIcon = display.newImage("icons/UploadIcon.png")
    saveIcon.width = appData.buttonWidth  / 4
    saveIcon.height = appData.buttonWidth  / 4
    saveIcon:setFillColor(unpack(appData.iconColor))

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
   local loadIcon = display.newImage("icons/DownloadIcon.png")
   loadIcon.width = appData.buttonWidth  / 4
   loadIcon.height = appData.buttonWidth  / 4
   loadIcon:setFillColor(unpack(appData.iconColor))

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
    resetButton.x = display.contentWidth / 2
    resetButton.y = bottomY - appData.buttonHeight * 1.25

    startButton.x = display.contentWidth / 2
    startButton.y = bottomY - (appData.buttonHeight * 4.25)


    speedUpButton.x = (display.contentWidth / 2) + appData.buttonWidth  / 2.75
    speedUpButton.y = bottomY - (appData.buttonHeight * 2.5)

    speedText.x = display.contentWidth / 2
    speedText.y = bottomY - (appData.buttonHeight * 2.5)

    speedDownButton.x = (display.contentWidth / 2) - appData.buttonWidth  / 2.75
    speedDownButton.y = bottomY - (appData.buttonHeight * 2.5)


    saveButton.x = appData.buttonWidth  / 4 
    saveButton.y = bottomY - appData.buttonHeight * 1.25
    
    loadButton.x = display.contentWidth - appData.buttonWidth  / 4
    loadButton.y = bottomY - appData.buttonHeight * 1.25

    --------------------------------------------------------------------|
   


    -- Insert Buttons into UIGroup
    uiGroup:insert(startButton) 
    uiGroup:insert(resetButton) 
    uiGroup:insert(speedUpButton) 
    uiGroup:insert(speedDownButton) 
    uiGroup:insert(speedText) 
    uiGroup:insert(saveButton) 
    uiGroup:insert(loadButton) 

    return uiGroup

end


return UI