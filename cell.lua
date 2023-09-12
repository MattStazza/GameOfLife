local composer = require("composer")
local appData = require("data")

local Cell = {}

local ALIVE_COLOR = {0, 1, 0} 
local DEAD_COLOR = {1, 1, 1}

function makeDead(self)
    self.isAlive = false
    self:setFillColor(unpack(DEAD_COLOR))
end

function makeAlive(self)
    self.isAlive = true
    self:setFillColor(unpack(ALIVE_COLOR))
end

function toggleCell(self)
    if self.isAlive then
        makeDead(self)
    else
        makeAlive(self)
    end
end

function Cell.new(x, y, size)
    local cellSize = size * appData.cellSizeModifier
    local self = display.newRect(x, y, cellSize, cellSize)
    self:setFillColor(1, 1, 1) 
    self:setStrokeColor(0, 0, 0)
    self.isAlive = false -- Initialize the tapped state

    function self:tap(event)
        toggleCell(self)
    end

    self:addEventListener("tap", self)

    return self
end

return Cell