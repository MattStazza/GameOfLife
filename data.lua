local M = {}  -- Module table

M.gridSize = 5
M.cells = {}

M.fileIDToLoad = 0

M.screenPercentage = 0.75 -- Percentage of the screen width for the gameBoard
M.speed = 1  -- Initialize Speed



-- UI Data
M.buttonHeight = 30
M.buttonWidth = 100
M.iconColor = {1, 1, 1}
M.backgroundColor = {0.1, 0.1, 0.1}
M.backgroundColor2 = {0.2, 0, 0.3}


function resetData()
    M.gridSize = 5
    M.cells = {}
end

return M