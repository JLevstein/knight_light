local pd <const> = playdate
local gfx <const> = pd.graphics

import "flashlight"

class('Player').extends(gfx.sprite)

-- playerSpriteSheet = nil;
-- currentSprite = nil;

function Player:init(x, y)
    self.direction = "north"


    self.playerSpritesheet = gfx.imagetable.new("images/player")
    local currentSprite = self.playerSpritesheet:getImage(3)
    self:setImage(currentSprite)
    self:setCollideRect(0,0,self:getSize())
    self:moveTo(x, y)
    self:add()

    local inputHandlers = {
        cranked = function(change, acceleratedChange)
            self:changeDirection()
        end
    }
    
    pd.inputHandlers.push(inputHandlers)
    self.flashlight = Flashlight(x, y)
end

function Player:changeDirection()
    local currentSprite = nil
    
    if pd.getCrankPosition() > 0 and pd.getCrankPosition() < 90 then
        currentSprite = self.playerSpritesheet:getImage(4)
        self.direction = "east"
        self.flashlight:setRotation(90)
    elseif pd.getCrankPosition() >= 90 and pd.getCrankPosition() < 180 then
        currentSprite = self.playerSpritesheet:getImage(1)
        self.direction = "south"
        self.flashlight:setRotation(180)
    elseif pd.getCrankPosition() >= 180 and pd.getCrankPosition() < 270 then
        currentSprite = self.playerSpritesheet:getImage(2)
        self.direction = "west"
        self.flashlight:setRotation(270)
    elseif pd.getCrankPosition() >= 270 and pd.getCrankPosition() < 360 then
        currentSprite = self.playerSpritesheet:getImage(3)
        self.direction = "north"
        self.flashlight:setRotation(0)
    end 
    
    self:setImage(currentSprite)
end

function Player:update()
    -- This works, but is too resource intensive? Better to just make a 4 or 8-way rotated sprite
    -- self:setRotation(playdate.getCrankPosition())

end