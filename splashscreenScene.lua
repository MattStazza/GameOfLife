-- Import the necessary libraries -----
local composer = require("composer")
local scene = composer.newScene()
---------------------------------------




-- CREATE SCENE
function scene:create(event)
    local sceneGroup = self.view

    -- Create your display objects (e.g., background, buttons, text) here
    
    -- Example background
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
    background:setFillColor(0.5, 0.5, 0.5)

    -- Example text
    local textOptions = {
        text = "Splash Screen!",
        x = display.contentCenterX,
        y = display.contentCenterY,
        font = native.systemFont,
        fontSize = 24,
    }
    local helloText = display.newText(textOptions)
    sceneGroup:insert(helloText)
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