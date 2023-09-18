local appData = require("data")
local fileID


-- Text File always valid because the Save function runs before
function setFileID()

    local path = system.pathForFile("saveID.txt", system.DocumentsDirectory)
    local file, errorString = io.open( path, "r" )
  
    if file then
        fileID = tonumber(file:read("*a") or 0) - 1 -- Need to remove 1 because SaveID has been incremented
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
                table.insert(cells, cell)
            end
        end
    
        file:close()
        appData.gridSize = gridSize
        appData.cells = cells
        updateCellSizeModifier(appData)
        print("Gameboard Loaded. FileID: " .. fileID)
    
      else
      print("Error: Unable to open file: " .. errorString)
    end

end




function loadSpecificGameboard() 

    local id = appData.fileIDToLoad

    local path = system.pathForFile("gameboard" .. tostring(id) .. ".txt", system.DocumentsDirectory)
    local file, errorString = io.open( path, "r" )

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
            table.insert(cells, cell)
        end
    end
    
    file:close()
    appData.gridSize = gridSize
    appData.cells = cells
    updateCellSizeModifier(appData)
    print("Gameboard Loaded. FileID: " .. id)

end