local appData = require("data")

-- Function to save the game board to a text file
function saveGameBoard()
    
  -- NEED TO FIX ABSALUTE PATH
  fileName = "D:/Programming Projects/GameOfLife/gameboard.txt"

  -- Try to open the file for writing, create it if it doesn't exist
  local file, errorString = io.open(fileName, "w+")
  if file then
    -- Write gridSize to the file
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
      
  -- Close the file
    file:close()
    print("Grid size saved to " .. fileName)
  else
    print("Error: Unable to create or open file.")
  end
end













  