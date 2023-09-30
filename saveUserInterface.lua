local composer = require("composer")
local widget = require("widget")
local appData = require("data")
local saver = require("saver")
local loader = require("loader")
-------------------------------------------------------------
local UI = {}

local oneDigit = 5
local oneDigitText
local tenDigit = 0
local tenDigitText
local hundredDigit = 0
local hundredDigitText
digitTextOptions = { text = "0", fontSize = 28, font = "TR-909.ttf"}
local customGridSize = 0

------------------------------ BUTTON FUNCTIONS ---------------------------|

local function onSaveButtonTap(self)
    saveGameBoard(saver)
    resetCounter(gameScene)
    loadGameBoard(loader)

    local transitionOptions = { effect = "fade", time = 500, }
    composer.gotoScene("gameScene", transitionOptions)
    resetDigits()
end


local function onCloseButtonTap(self)
    print("Close")
    resetDigits()
    appData.gridSize = 5
    appData.cells = {}
    local transitionOptions = { effect = "slideDown", time = 750, }
    composer.gotoScene("gameScene", transitionOptions)
end


local function onRandomButtonTap(self)
    randomiseCells()
end


local function onEraseButtonTap(self)
    resetCells()
end


-- Digit Control Functions (to set grid size) --

local function onOneUpButtonTap(self)
    oneDigit = oneDigit + 1
    if tenDigit == 0 and hundredDigit == 0 then
        if oneDigit >= 10 or oneDigit <= 4 then
            oneDigit = 5
        end
    end
    if oneDigit == 10 then
        oneDigit = 0
    end
    oneDigitText.text = oneDigit
end

local function onOneDownButtonTap(self)
    oneDigit = oneDigit - 1
    if tenDigit == 0 and hundredDigit == 0 then
        if oneDigit <= 4 then
            oneDigit = 9
        end
    end
    if oneDigit == -1 then
        oneDigit = 9
    end
    oneDigitText.text = oneDigit
end

local function onTenUpButtonTap(self)
    tenDigit = tenDigit + 1
    if tenDigit == 10 then
        tenDigit = 0
    end
    tenDigitText.text = tenDigit
end

local function onTenDownButtonTap(self)
    tenDigit = tenDigit - 1
    if tenDigit == -1 then
        tenDigit = 9
    end
    tenDigitText.text = tenDigit
end

local function onHundredUpButtonTap(self)
    hundredDigit = hundredDigit + 1
    if hundredDigit == 3 then
        hundredDigit = 0
    end
    hundredDigitText.text = hundredDigit
end

local function onHundredDownButtonTap(self)
    hundredDigit = hundredDigit - 1
    if hundredDigit == -1 then
        hundredDigit = 2
    end
    hundredDigitText.text = hundredDigit
end


local function updateGridSizeOnButtonTap(self)
    
    newGridSize = getCustomGridSize()

    -- Limit Grid Size (between 005 & 200)
    if newGridSize <= 004 or newGridSize >= 201 then
        newGridSize = 005
        resetDigits()
    end
    
    -- Update Grid Size to be out custom value
    appData.gridSize = newGridSize
    
    -- Reload the Scene to see changes
    composer.gotoScene("saveScene")
end


function getCustomGridSize()
    customGridSize = tonumber(hundredDigit .. tenDigit .. oneDigit)
    return customGridSize
end

function resetDigits()
    oneDigit = 5
    oneDigitText.text = oneDigit
    tenDigit = 0
    tenDigitText.text = tenDigit
    hundredDigit = 0
    hundredDigitText.text = hundredDigit
end
------------------------------------------------------------------------------|


function UI.createUI()
    
    local uiGroup = display.newGroup()
    
    --================== CREATING BUTTONS ====================================|

    -- SAVE/LOAD BUTTON --
    saveButton = widget.newButton({
        width = appData.buttonWidth ,    
        height = appData.buttonHeight,
        label = "SAVE",
        font = "TR-909.ttf",
        fontSize = 16,
        labelColor = { default={0,0,0}, over={0,0,0} },
        shape = "roundedRect",
        fillColor = { default={1, 0.5, 1}, over={0.5, 0.5, 0.5} },
        onRelease = function(event)
            onSaveButtonTap(self)
        end
    })

    -- CLOSE BUTTON -- 
   local closeButton = widget.newButton({
        width = appData.buttonWidth ,    
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

    --------------------- ONE DIGIT TEXT & BUTTONS ------------------------
    oneDigitText = display.newText(digitTextOptions)

    -- UP BUTTON -- 
    local oneDigitUpButton = widget.newButton({
        width = appData.buttonWidth  / 6,    
        height = appData.buttonHeight / 2,
        label = "▲",
        fontSize = 12,
        labelColor = { default={0,0,0}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onOneUpButtonTap(self)
            updateGridSizeOnButtonTap(self)
        end
    })
    
    -- DOWN BUTTON -- 
    local oneDigitDownButton = widget.newButton({
        width = appData.buttonWidth  / 6,    
        height = appData.buttonHeight / 2,
        label = "▼",
        fontSize = 12,
        labelColor = { default={0,0,0}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onOneDownButtonTap(self)
            updateGridSizeOnButtonTap(self)
        end
    })
    --------------------------------------------------------------------

    --------------------- TEN DIGIT TEXT & BUTTONS ---------------------
    tenDigitText = display.newText(digitTextOptions)

    -- UP BUTTON -- 
    local tenDigitUpButton = widget.newButton({
        width = appData.buttonWidth  / 6,    
        height = appData.buttonHeight / 2,
        label = "▲",
        fontSize = 12,
        labelColor = { default={0,0,0}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onTenUpButtonTap(self)
            updateGridSizeOnButtonTap(self)
        end
    })
    
    -- DOWN BUTTON -- 
    local tenDigitDownButton = widget.newButton({
        width = appData.buttonWidth  / 6,    
        height = appData.buttonHeight / 2,
        label = "▼",
        fontSize = 12,
        labelColor = { default={0,0,0}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onTenDownButtonTap(self)
            updateGridSizeOnButtonTap(self)
        end
    })
    --------------------------------------------------------------------

    --------------------- HUNDRED DIGIT TEXT & BUTTONS -----------------
    hundredDigitText = display.newText(digitTextOptions)

    -- UP BUTTON -- 
    local hundredDigitUpButton = widget.newButton({
        width = appData.buttonWidth  / 6,    
        height = appData.buttonHeight / 2,
        label = "▲",
        fontSize = 12,
        labelColor = { default={0,0,0}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onHundredUpButtonTap(self)
            updateGridSizeOnButtonTap(self)
        end
    })
    
    -- DOWN BUTTON -- 
    local hundredDigitDownButton = widget.newButton({
        width = appData.buttonWidth  / 6,    
        height = appData.buttonHeight / 2,
        label = "▼",
        fontSize = 12,
        labelColor = { default={0,0,0}, over={0.5,0.5,0.5} },
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0.2,0.6,0.2,0.6} },
        onRelease = function(event)
            onHundredDownButtonTap(self)
            updateGridSizeOnButtonTap(self)
        end
    })
    --------------------------------------------------------------------

    --------------------- RANDOMISE & CLEAR BUTTONS -----------------
    -- RANDOMISE BUTTON -- 
    local randomIcon = display.newImage("icons/RandomIcon.png")
    randomIcon.width = appData.buttonWidth  / 3
    randomIcon.height = appData.buttonWidth  / 3
    randomIcon:setFillColor(unpack(appData.iconColor))

    local randomiseButton = widget.newButton({
        width = appData.buttonWidth  / 4,    
        height = appData.buttonHeight,
        onRelease = function(event)
            onRandomButtonTap(self)
        end
    })

    randomIcon.x = saveButton.width / 2
    randomIcon.y = saveButton.height / 2
    randomiseButton:insert(randomIcon)


   -- ERASE BUTTON -- 
   local eraseIcon = display.newImage("icons/EraseIcon.png")
   eraseIcon.width = appData.buttonWidth  / 3
   eraseIcon.height = appData.buttonWidth  / 3
   eraseIcon:setFillColor(unpack(appData.iconColor))

   local eraseButton = widget.newButton({
       width = appData.buttonWidth / 4,    
       height = appData.buttonHeight,
       onRelease = function(event)
            onEraseButtonTap(self)
       end
   })

   eraseIcon.x = eraseButton.width / 2
   eraseIcon.y = eraseButton.height / 2
   eraseButton:insert(eraseIcon)  

    --===================================================================|

    -------------- POSITIONING BUTTONS ----------------------------------|

    -- Calculate the bottom position
    local bottomY = display.contentHeight
    
    -- Set the position of the button
    closeButton.x = display.contentWidth / 2
    closeButton.y = bottomY - (appData.buttonHeight * 1.25)

    saveButton.x = display.contentWidth / 2
    saveButton.y = bottomY - (appData.buttonHeight * 2.5)

    -- Position Digit Text & Buttons (shared variables)
    local xPos = display.contentWidth / 2
    local yPos = bottomY - (appData.buttonHeight * 4.25)
    local digitUpButtonYPos = yPos - appData.buttonHeight / 1.5
    local digitDownButtonYPos = yPos + appData.buttonHeight / 1.5

    -- Position One Digit Text & Buttons
    oneDigitUpButton.x = xPos + appData.buttonWidth / 4
    oneDigitUpButton.y = digitUpButtonYPos
    oneDigitText.x = xPos + appData.buttonWidth / 4
    oneDigitText.y = yPos 
    oneDigitDownButton.x = xPos + appData.buttonWidth / 4
    oneDigitDownButton.y = digitDownButtonYPos

    -- Position Ten Digit Text & Buttons
    tenDigitUpButton.x = xPos
    tenDigitUpButton.y = digitUpButtonYPos
    tenDigitText.x = xPos
    tenDigitText.y = yPos
    tenDigitDownButton.x = xPos
    tenDigitDownButton.y = digitDownButtonYPos

    -- Position Hundred Digit Text & Buttons
    hundredDigitUpButton.x = xPos - appData.buttonWidth / 4
    hundredDigitUpButton.y = digitUpButtonYPos
    hundredDigitText.x = xPos - appData.buttonWidth / 4
    hundredDigitText.y = yPos
    hundredDigitDownButton.x = xPos - appData.buttonWidth / 4
    hundredDigitDownButton.y = digitDownButtonYPos

    -- Position Randomise Button
    randomiseButton.x = display.contentWidth / 2 - appData.buttonWidth
    randomiseButton.y = digitUpButtonYPos + appData.buttonHeight / 1.5

    -- Position Erase Button
    eraseButton.x = display.contentWidth / 2.25 + appData.buttonWidth
    eraseButton.y = digitUpButtonYPos + appData.buttonHeight / 1.5

    --------------------------------------------------------------------|
   
    -- Insert Buttons into UIGroup
    uiGroup:insert(saveButton) 
    uiGroup:insert(closeButton)

    uiGroup:insert(oneDigitText) 
    uiGroup:insert(oneDigitUpButton) 
    uiGroup:insert(oneDigitDownButton) 

    uiGroup:insert(tenDigitText) 
    uiGroup:insert(tenDigitUpButton) 
    uiGroup:insert(tenDigitDownButton) 

    uiGroup:insert(hundredDigitText) 
    uiGroup:insert(hundredDigitUpButton) 
    uiGroup:insert(hundredDigitDownButton) 

    uiGroup:insert(randomiseButton)
    uiGroup:insert(eraseButton)

    return uiGroup

end


return UI