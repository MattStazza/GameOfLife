-- Import the necessary libraries
local composer = require("composer")

-- Function to transition to a Game
local function goToGameScene()
    composer.gotoScene("gameScene")
end

-- Load Splash screen
composer.gotoScene("splashscreenScene")

-- Go to Game Scene after 3sec
timer.performWithDelay(3000, goToGameScene)

-- Import the test framework & run tests
require("lunatest")