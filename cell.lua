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
    local self = display.newRect(x, y, cellSize, cellSize)

    self.fill.effect = "generator.linearGradient"
    self.fill.effect.color1 = { 0.9, 1, 1, 1 }
    self.fill.effect.position1  = { 1, 0.5 }
    self.fill.effect.color2 = { 0.9, 0.9, 0.9, 1 }
    self.fill.effect.position2  = { 0.5, 1 }

    self.isAlive = false

    function self:tap(event)
        toggleCell(self)
    end

    self:addEventListener("tap", self)

    return self
end

return Cell