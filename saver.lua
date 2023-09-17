local appData = require("data")


local saveID





local function getSaveID()

  local path = system.pathForFile("saveID.txt", system.DocumentsDirectory)
  local file, errorString = io.open( path, "r" )

  -- If the file doesn't exist... Set SaveID & create new file.
  if errorString then
    local file, errorString = io.open( path, "w" )
    saveID = 0
    file:write(tostring(saveID))
    file:close()
  end

  if file then
    saveID = tonumber(file:read("*a") or 0)
    print("Current SaveID:" .. saveID)
    file:close()
  else
    print("Can't find saveID file: " .. errorString)
  end
end


local function incrementSaveID()
  saveID = saveID + 1

  local path = system.pathForFile("saveID.txt", system.DocumentsDirectory)
  local file, errorString = io.open( path, "w" )

  if file then
    file:write(saveID)
    file:close()
  else
    print("Couldn't increment SaveID: " .. errorString)
  end

end




-- Function to save the game board to a text file
function saveGameBoard()

  getSaveID()

  local path = system.pathForFile("gameboard" .. tostring(saveID) .. ".txt", system.DocumentsDirectory)
  local file, errorString = io.open( path, "w" )

  if file then
    file:write(appData.gridSize .. "\n")
      
    count = 0

    -- Loop through the cells table
    for index, cell in ipairs(appData.cells) do

      if cell.isAlive then
        file:write("X ")
      else
        file:write("O ")
      end

      count = count + 1
        
      if count == appData.gridSize then
        file:write("\n")
        count = 0
      end
  end
      
    incrementSaveID()
    print("Gameboard Saved")
    file:close()

  else
    print("Error: Unable to create or open file: " .. errorString)
  end
end














  