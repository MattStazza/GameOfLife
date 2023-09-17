local appData = require("data")
local fileID


-- Text File always valid because the Save function runs before
local function setFileID()

    local path = system.pathForFile("saveID.txt", system.DocumentsDirectory)
    local file, errorString = io.open( path, "r" )
  
    if file then
        fileID = tonumber(file:read("*a") or 0) - 1 -- Need to remove 1 because SaveID has been incremented
      print("Current FileID:" .. fileID)
      file:close()
    end
  end




function loadGameBoard()

    setFileID()

    local path = system.pathForFile("gameboard" .. tostring(fileID) .. ".txt", system.DocumentsDirectory)
    local file, errorString = io.open( path, "r" )
  
    if file then
        local gridSize = tonumber(file:read("*line"))
        local cells = {}
    
        for line in file:lines() do
            local row = {}
          
            for char in line:gmatch("%S") do
                local cell = {}
                if char == "X" then
                    cell.isAlive = true
                else
                    cell.isAlive = false
                end
                --print(cell.isAlive)
                table.insert(row, cell)
            end

            table.insert(cells, row)
        end
    
        file:close()
        appData.gridSize = gridSize
        appData.cells = cells
        print("Gameboard Loaded")
    
      else
      print("Error: Unable to open file: " .. errorString)
    end

end