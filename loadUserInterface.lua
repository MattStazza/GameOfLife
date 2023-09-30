local composer = require("composer")
local widget = require("widget")
local appData = require("data")
local loader = require("loader")
-------------------------------------------------------------

local UI = {}

local count = 1
local totalPresets = 0
local openingLoadScene = true
local presetIndicatorText
presetIndicatorTextTextOptions = { text = "No Presets", fontSize = 24, font = "TR-909.ttf",}

--------------- BUTTON FUNCTIONS ---------------------------|

local function onLoadButtonTap(self)
    print("Load")
    LeavingLoadScene()
    local transitionOptions = { effect = "fade", time = 500, }
    composer.gotoScene("gameScene", transitionOptions)
end

local function onCloseButtonTap(self)
    print("Close")
    LeavingLoadScene()
    resetData(appData)
    local transitionOptions = { effect = "slideUp", time = 750, }
    composer.gotoScene("gameScene", transitionOptions)
end

local function onLeftButtonTap(self)
    if totalPresets == 0 then
        return
    end
    count = count - 1
    if count <= 0 then
        count = totalPresets
    end
    presetIndicatorText.text = count .. " / " .. totalPresets
    loadCurrentPreset()
end

local function onRightButtonTap(self)
    if totalPresets == 0 then
        return
    end
    count = count + 1
    if count >= totalPresets + 1 then
        count = 1
    end
    presetIndicatorText.text = count .. " / " .. totalPresets
    loadCurrentPreset()
end

---------------------------------------------------------------|


function loadCurrentPreset()
    openingLoadScene = false
    appData.fileIDToLoad = count - 1
    loadSpecificGameboard(loader)   
    composer.gotoScene("loadScene") -- Reload the Scene to see changes
end


function setTotalNumberOfSaveFiles()
    
    local path = system.pathForFile("fileID.txt", system.DocumentsDirectory)
    local file, errorString = io.open( path, "r" )
  
    if file then
        totalPresets = tonumber(file:read("*a") or 0)
        file:close()
    else
        totalPresets = 0
    end

    if totalPresets == 0 then
        presetIndicatorText.text = "No Presets Saved"
    else
        presetIndicatorText.text = count .. " / " .. totalPresets
    end
end

-- This loads the first save when the user opens the Load Scene
function EnteringLoadScene()
    if totalPresets == 0 then
        return
    end
    if openingLoadScene then
        appData.fileIDToLoad = count - 1
        loadSpecificGameboard(loader)   
    end
end
function LeavingLoadScene()
    count = 1
    openingLoadScene = true
end


function UI.createUI()
    
    local uiGroup = display.newGroup()
    
    --============== CREATING BUTTONS ====================================|

    -- LOAD BUTTON --
    loadButton = widget.newButton({
        width = appData.buttonWidth  ,    
        height = appData.buttonHeight,
        label = "LOAD",
        font = "TR-909.ttf",
        fontSize = 16,
        labelColor = { default={0,0,0}, over={0,0,0} },
        shape = "roundedRect",
        fillColor = { default={1, 0.5, 1}, over={0.5, 0.5, 0.5} },
        onRelease = function(event)
            onLoadButtonTap(self)
        end
    })

    -- CLOSE BUTTON -- 
   local closeButton = widget.newButton({
        width = appData.buttonWidth  ,    
        height = appData.buttonHeight,
        label = "CLOSE",
        font = "TR-909.ttf",
        fontSize = 16,
        labelColor = { default={0,0,0}, over={0,0,0} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.5,0.5,0.5, 1} },
        onRelease = function(event)
            onCloseButtonTap(self)
        end
    })

    -------------------------------------------------------------------

    -- LEFT BUTTON -- 
    local leftIcon = display.newImage("icons/leftIcon.png")
    leftIcon.width = appData.buttonWidth / 4
    leftIcon.height = appData.buttonWidth / 4
    leftIcon:setFillColor(unpack(appData.iconColor))

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
    local rightIcon = display.newImage("icons/rightIcon.png")
    rightIcon.width = appData.buttonWidth  / 4
    rightIcon.height = appData.buttonWidth  / 4
    rightIcon:setFillColor(unpack(appData.iconColor))

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
    presetIndicatorText = display.newText(presetIndicatorTextTextOptions)
    setTotalNumberOfSaveFiles()

    --===================================================================|


    -------------- POSITIONING BUTTONS ----------------------------------|

    -- Calculate the bottom position
    local bottomY = display.contentHeight
    
    -- Set the position of the button
    closeButton.x = display.contentWidth / 2
    closeButton.y = bottomY - appData.buttonHeight * 1.25

    loadButton.x = display.contentWidth / 2
    loadButton.y = bottomY - (appData.buttonHeight * 2.5)

    leftButton.x = 0 + (appData.buttonWidth / 5)
    leftButton.y = display.contentHeight / 2.5
    
    rightButton.x = display.contentWidth - (appData.buttonWidth / 5)
    rightButton.y = display.contentHeight / 2.5

    presetIndicatorText.x = display.contentWidth / 2
    presetIndicatorText.y = bottomY - (appData.buttonHeight * 4)

    --------------------------------------------------------------------|
   

    -- Insert Buttons into UIGroup
    uiGroup:insert(loadButton) 
    uiGroup:insert(closeButton)
    uiGroup:insert(leftButton) 
    uiGroup:insert(rightButton)
    uiGroup:insert(presetIndicatorText)

    return uiGroup

end

return UI