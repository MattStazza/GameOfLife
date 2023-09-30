-- Import the necessary libraries -----
local composer = require("composer")
local scene = composer.newScene()
local appData = require("data")
local Cell = require("cell")
local UI = require("saveUserInterface")

-----------------------------------------------------
local cells = {}

local function addUserInterface(group)
    ui = UI.createUI()
    group:insert(ui)
end

local function createBoard(group)
    
    cellSize = display.actualContentWidth * appData.screenPercentage / appData.gridSize
    
    -- Remove current board before making the new board
    display.remove(board)
    board = nil

    -- Create a display group for the grid
    board = display.newGroup()

    cells = {} -- Must Empty Cells
    appData.cells = {}
    
    for row = 1, appData.gridSize do
        for col = 1, appData.gridSize do
            local x = (col - 1) * cellSize
            local y = (row - 1) * cellSize
            local newCell = Cell.new(x, y, cellSize)

            local index = (row - 1) * appData.gridSize + col
            cells[index] = newCell -- Insert the cell into the cells table
            appData.cells[index] = newCell

            board:insert(newCell) -- Insert the cell into the Board group
        end
    end

    -- Center the Board
    board.x = display.contentCenterX - (cellSize * (appData.gridSize - 1)) / 2
    board.y = (display.contentCenterY - (cellSize * (appData.gridSize - 1)) / 2) - (appData.buttonHeight * 2)

    -- Insert the Board into the Scene
    group:insert(board) 

end


function randomiseCells()
    for index, cell in ipairs(cells) do

        chance = math.random(2, 15)
        random = math.random(1, chance)

        if (random == 1) then
            makeAlive(cell)
        else 
            makeDead(cell)
        end
    end
end


function resetCells()
    for index, cell in ipairs(cells) do
        if cell.isAlive then
            makeDead(cell)
        end
    end
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
        text = "Create a Preset",
        x = display.contentWidth / 2,
        y = 35, 
        font = "TR-909.ttf",
        fontSize = 22,
    }
    local infoText = display.newText(textOptions)
    sceneGroup:insert(infoText)

    -- User Interface (Save Scene)
    addUserInterface(sceneGroup)
    resetDigits(saveScene)
end


-- SHOW SCENE
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is about to come on screen
        createBoard(sceneGroup)
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
        resetCells()
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