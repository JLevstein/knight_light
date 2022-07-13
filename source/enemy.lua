import "external/AnimatedSprite"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(AnimatedSprite)

function Enemy:init(x, y, direction)
    self.travelDirection = nil
    self.health = 100
    
    local spritesheet = gfx.imagetable.new("images/enemy")
    Enemy.super.init(self, spritesheet)
    
    self:addState("idle", 1, 3, { yoyo = true, tickStep = 6 })
    self:playAnimation()
    self:moveTo(x, y)
    
    self:changeDirection(direction)
end

function Enemy:changeDirection(newDirection)
    self.travelDirection = newDirection
    
    if newDirection == "north" then
        self:setRotation(180)
    elseif newDirection == "south" then
        -- do 
    elseif newDirection == "east" then
        self:setRotation(270)
    elseif newDirection == "west" then
        self:setRotation(90)
    end

    local path = pd.geometry.lineSegment.new(self.x, self.y, 200, 120)
    local pathAnim = gfx.animator.new(4000, path, pd.easingFunctions.linear)

    self:setAnimator(pathAnim, false)
end

function Enemy:update()
    self:setCollideRect(0, 0, self:getSize())
    
    local collisions = self:overlappingSprites()
    
    for i = 1, #collisions do
        local other = collisions[i]
        
        if other:isa(Flashlight) then
            self:subtractHealth()
        end
    end

    self:updateAnimation()
end

function Enemy:subtractHealth()
    self.health -= 5
    
    if self.health <= 0 then
        self:removeSprite(self)
    end
end

function Enemy:collisionResponse(other)
    return "overlap"
end