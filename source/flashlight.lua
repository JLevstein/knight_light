local pd <const> = playdate
local gfx <const> = pd.graphics

import 'enemy'

class('Flashlight').extends(gfx.sprite)

function Flashlight:init(x, y)
    local flashlightImage = gfx.image.new("images/flashlight")
    self:setImage(flashlightImage)
    self:setCenter(0.5, 1)
    self:setCollideRect(0,0,self:getSize())
    self:moveTo(x, y)
    self:add()
end

function Flashlight:updateRect()
    self:setCollideRect(0,0,self:getSize())
end

function Flashlight:update()
    -- This works, but is too resource intensive? Better to just make a 4 or 8-way rotated sprite
    -- self:setRotation(playdate.getCrankPosition())
end