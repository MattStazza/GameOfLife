local appData = require("data")
local fileID


local function setFileID()

  local path = system.pathForFile("fileID.txt", system.DocumentsDirectory)
  local file, errorString = io.open( path, "r" )

  -- If the file doesn't exist... Set FileID & create new file.
  if errorString then
    local file, errorString = io.open( path, "w" )
    fileID = 0
    file:write(tostring(fileID))
    file:close()
  end

  if file then
    fileID = tonumber(file:read("*a") or 0)
    file:close()
  else
    print("Can't find fileID file: " .. errorString)
  end
end



local function incrementFileID()
  fileID = fileID + 1

  local path = system.pathForFile("fileID.txt", system.DocumentsDirectory)
  local file, errorString = io.open( path, "w" )

  if file then
    file:write(fileID)
    file:close()
  else
    print("Couldn't increment FileID: " .. errorString)
  end

end


-- Function to save the gameboard to a text file
function saveGameBoard()

  setFileID()

  local path = system.pathForFile("gameboard" .. tostring(fileID) .. ".txt", system.DocumentsDirectory)
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
      
    incrementFileID()
    print("Gameboard Saved. FileID: " .. fileID - 1)
    file:close()

  else
    print("Error: Unable to create or open file: " .. errorString)
  end
end