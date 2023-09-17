local M = {}  -- Module table

M.gridSize = 5 -- Initialize Grid Size
M.cells = {}
M.cellSizeModifier = 0.95

M.screenPercentage = 0.75 -- Percentage of the screen width for the gameBoard
M.speed = 1  -- Initialize Speed

M.buttonHeight = 30
M.buttonWidth = 100


function updateCellSizeModifier()
    if (M.gridSize <= 20) then
        M.cellSizeModifier = 0.95
    elseif (M.gridSize <= 50) then
        M.cellSizeModifier = 0.85
    elseif (M.gridSize <= 75) then
        M.cellSizeModifier = 0.75
    else
        M.cellSizeModifier = 1
    end
end


return M