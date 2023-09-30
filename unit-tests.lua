module(..., package.seeall)


function test_example()
    assert_true(true, "This is a simple test")
end

--=============================|GAME SCENE TESTS|--=============================|--

function test_ResetCounter()
    gameSceneData.stepCount = 100
    resetCounter()
    assert_true(gameSceneData.stepCount == 0)
end


function test_PauseSimulation()
    gameSceneData.running = true
    pauseSimulation()
    assert_true(gameSceneData.running == false)
end
