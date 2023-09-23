-- Import the necessary libraries -----
local composer = require("composer")
local appData = require("data")
local scene = composer.newScene()
---------------------------------------




-- CREATE SCENE
function scene:create(event)
    local sceneGroup = self.view

    -- Example background
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
    background:setFillColor(unpack(appData.backgroundColor2))

    -- Splash Screen Title Text
    local textOptions = {
        text = "GAME\nOF LIFE",
        x = display.contentCenterX,
        y = 80,
        font = "TR-909.ttf",
        fontSize = 50,
    }
    local TitleText = display.newText(textOptions)
    sceneGroup:insert(TitleText)
    

    -- GAME APP BUTTON -- 
    local gameAppIcon = display.newImage("icons/GameAppIcon.png")
    gameAppIcon.width = appData.buttonWidth * 2
    gameAppIcon.height = appData.buttonWidth * 2
    gameAppIcon:setFillColor(unpack(appData.iconColor))

    sceneGroup:insert(gameAppIcon)   
    gameAppIcon.x = display.contentWidth / 2
    gameAppIcon.y = display.contentHeight / 1.75

    sceneGroup:insert(gameAppIcon)  


    -- Splash Screen Information Text
    local textOptions = {
        text = "DEVELOPED BY:\nMATTHEW STASINOWSKY\n\n2023",
        x = display.contentCenterX,
        y = display.contentHeight - 10,
        font = "TR-909.ttf",
        fontSize = 15,
    }
    local InformationText = display.newText(textOptions)
    sceneGroup:insert(InformationText)
end


-- SHOW SCENE
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is about to come on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
    end
end


-- HIDE SCENE
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
    elseif phase == "did" then
        -- Called when the scene has moved off screen
    end
end


-- DESTROY SCENE
function scene:destroy(event)
    local sceneGroup = self.view

    -- Clean up any resources used by the scene
end




-- Event Listeners --------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-------------------------------------------------


return scene