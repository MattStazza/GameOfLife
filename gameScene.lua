-- Import the necessary libraries -----
local composer = require("composer")
local scene = composer.newScene()

local Cell = require("cell")
local UI = require("gameUserInterface")
local appData = require("data")
-----------------------------------------------------

local cellSize = display.actualContentWidth * appData.screenPercentage / appData.gridSize

local running = false
local stepCount = 0
local stepText
local stepTextOptions = { text = "0", fontSize = 15, }

-----------------------------------------------------




local cells = {}

local function createGameBoard(group)
    
    gameBoard = display.newGroup() -- Create a display group for the grid

    for row = 1, appData.gridSize do
        for col = 1, appData.gridSize do
            local x = (col - 1) * cellSize
            local y = (row - 1) * cellSize
            local newCell = Cell.new(x, y, cellSize)

            local index = (row - 1) * appData.gridSize + col
            cells[index] = newCell -- Insert the cell into the cells table

            gameBoard:insert(newCell) -- Insert the cell into the gameBoard group
        end
    end

    -- Center the gameBoard
    gameBoard.x = display.contentCenterX - (cellSize * (appData.gridSize - 1)) / 2
    gameBoard.y = display.contentCenterY - gameBoard.height / 1.5

    -- Display & position step text 
    stepText = display.newText(stepTextOptions)
    gameBoard:insert(stepText) 
    stepText.x = (appData.gridSize * cellSize) - 10
    stepText.y = (appData.gridSize * cellSize) + 10

    -- Insert the GameBoard into the Scene
    group:insert(gameBoard) 

end


function resetCells()
    for index, cell in ipairs(cells) do
        if cell.isAlive then
            makeDead(cell)
            print("Killed Cell:", index)
        end
    end
    stepCount = 0
    stepText.text = stepCount
end


-- Returns the Indexs of the Cells neighbouring a specific Cell.
local function getCellsNeighbours(cellIndex)
    local neighbours = {}
    
    local row, col = math.ceil(cellIndex / appData.gridSize), cellIndex % appData.gridSize
    col = (col == 0) and appData.gridSize or col
    
    local offsets = {
        { -1, -1 }, { -1, 0 }, { -1, 1 },
        { 0, -1 },            { 0, 1 },
        { 1, -1 }, { 1, 0 }, { 1, 1 }
    }

    for _, offset in ipairs(offsets) do
        local newRow, newCol = row + offset[1], col + offset[2]
        
        newRow = (newRow - 1) % appData.gridSize + 1
        newCol = (newCol - 1) % appData.gridSize + 1
        
        local newIndex = (newRow - 1) * appData.gridSize + newCol
        table.insert(neighbours, newIndex)
    end
    
    return neighbours
end





function startSimulation()

    print("Started")
    running = true

    local dyingCells = {}
    local rebornCells = {}
 

    local function updateCellStates()
        -- Make dying cells dead
        for _, index in ipairs(dyingCells) do
            makeDead(cells[index])
        end
        
        -- Make reborn cells alive
        for _, index in ipairs(rebornCells) do
            makeAlive(cells[index])
        end

        -- Empty tables
        dyingCells = {}
        rebornCells = {}
    end


    local function simulationStep()

        if not running then
            return
        end
        
        print("step")
        stepCount = stepCount + 1
        stepText.text = stepCount

        for index, cell in ipairs(cells) do
            
            -- Get Cell's Neighbours 
            local neighborIndices = getCellsNeighbours(index)
            
            local aliveNeighbours = 0

            -- Loop through the Cell's Neighbours
            for _, neighborIndex in ipairs(neighborIndices) do
                
                -- Track how many neighbours are alive
                if cells[neighborIndex].isAlive then
                    aliveNeighbours = aliveNeighbours + 1
                end
    
            end
    
            -- If cell is alive...
            if cells[index].isAlive then
                if aliveNeighbours == 2 or aliveNeighbours == 3 then
                    table.insert(rebornCells, index)
                else
                    table.insert(dyingCells, index)
                end
    
            -- If Cell is dead...
            else
                if aliveNeighbours == 3 then
                    table.insert(rebornCells, index)
                end
            end

        end

        updateCellStates()   
        timer.performWithDelay(1000 / appData.speed, simulationStep) 

    end

    simulationStep() -- Start loop

end


function stopSimulation()
    print("Stopped")
    running = false
end



local function addUserInterface(group)
    ui = UI.createUI()
    group:insert(ui) -- Insert UI into Scene
end








--===============================================================================================================================||
--================================================- SCENE EVENT FUNCTIONS -======================================================||
--===============================================================================================================================||




-- CREATE SCENE
function scene:create(event)
    local sceneGroup = self.view

    -- Background
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
    background:setFillColor(1, 0, 1)

    -- Title Text
    local textOptions = {
        text = "Game of Life!",
        x = display.contentWidth / 2,
        y = 35, -- 35px down from top top
        font = native.systemFont,
        fontSize = 24,
    }
    titleText = display.newText(textOptions)
    sceneGroup:insert(titleText)

    -- Gameboard (Grid)
    createGameBoard(sceneGroup)

    -- User Interface (Game Scene)
    addUserInterface(sceneGroup)
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
        stopSimulation()
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