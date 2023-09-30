module(..., package.seeall)

local appData = require("data")

--=============================|GAME SCENE TESTS|--=============================|--

-- gameSceneData.stepCount should always be 0 after resetCounter()
function test_ResetCounter()
    gameSceneData.stepCount = 100
    resetCounter()
    assert_true(gameSceneData.stepCount == 0)
end

-- gameSceneData.running should always be false after pauseSimulation()
function test_PauseSimulation()
    gameSceneData.running = true
    pauseSimulation()
    assert_true(gameSceneData.running == false)
end

-- There should always be 8 Neighbours
function test_GetCellsNeighbours()
    randomCellIndex = 5
    testNeighbours = getCellsNeighbours(randomCellIndex)
    assert_true(#testNeighbours == 8)
end

--=============================================================================|--