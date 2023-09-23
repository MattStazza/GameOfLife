-- Import the necessary libraries -----
local composer = require("composer")
local scene = composer.newScene()

local appData = require("data")
local loader = require("loader")
local Cell = require("cell")
local UI = require("loadUserInterface")
---------------------------------------


local function addUserInterface(group)
    ui = UI.createUI()
    group:insert(ui)
end


local function createBoard(group)
    
    cellSize = display.actualContentWidth * appData.screenPercentage / appData.gridSize
    
    -- Remove current board before making the new board
    display.remove(board)
    board = nil
    cells = {} -- Must Empty Cells
    
    -- Create a display group for the grid
    board = display.newGroup()
    
    for row = 1, appData.gridSize do
        for col = 1, appData.gridSize do
            local x = (col - 1) * cellSize
            local y = (row - 1) * cellSize
            local newCell = Cell.new(x, y, cellSize)   
            local index = (row - 1) * appData.gridSize + col
            cells[index] = newCell -- Insert the cell into the cells table
            disableCell(newCell)

            board:insert(newCell) -- Insert the cell into the gameBoard group
        end
    end

    -- Load Cells
    for index, cell in ipairs(appData.cells) do
        if cell.isAlive then
           makeAlive(cells[index])
        else
           makeDead(cells[index])
        end
    end

    -- Center the Board
    board.x = display.contentCenterX - (cellSize * (appData.gridSize - 1)) / 2
    board.y = (display.contentCenterY - (cellSize * (appData.gridSize - 1)) / 2) - (appData.buttonHeight * 2)

    -- Insert the Board into the Scene
    group:insert(board) 

end



--===============================================================================================================================||
--================================================- SCENE EVENT FUNCTIONS -======================================================||
--===============================================================================================================================||



-- CREATE SCENE
function scene:create(event)
    local sceneGroup = self.view

    -- Background
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
    background:setFillColor(unpack(appData.backgroundColor2))

    -- Title Text
    local textOptions = {
        text = "Load a Preset",
        x = display.contentWidth / 2,
        y = 35, 
        font = "TR-909.ttf",
        fontSize = 25,
    }
    local infoText = display.newText(textOptions)
    sceneGroup:insert(infoText)

    -- User Interface (Load Scene)
    addUserInterface(sceneGroup)
end


-- SHOW SCENE
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is about to come on screen
        EnteringLoadScene()
        createBoard(sceneGroup)
        setTotalNumberOfSaveFiles()
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