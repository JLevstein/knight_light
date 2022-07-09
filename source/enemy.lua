local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(gfx.sprite)

function Enemy:init(x, y, direction)
    self.travelDirection = nil
    self.health = 100
    self.spritesheet = gfx.imagetable.new("images/enemy")
    local currentSprite = self.spritesheet:getImage(1)
    self:setImage(currentSprite)
    self:moveTo(x, y)
    self:add()

    self:changeDirection(direction)
end

function Enemy:changeDirection(newDirection)
    self.travelDirection = newDirection
    
    if newDirection == "north" then
        self:setRotation(180)
    elseif newDirection == "south" then
    elseif newDirection == "east" then
        self:setRotation(270)
    elseif newDirection == "west" then
        self:setRotation(90)
    end
    self:setCollideRect(0,0,self:getSize())

    local path = pd.geometry.lineSegment.new(self.x, self.y, 200, 120)
    local anim = gfx.animator.new(4000, path, pd.easingFunctions.linear)

    self:setAnimator(anim, true)
end

function Enemy:update()
    local collisions = self:overlappingSprites()
    for i = 1, #collisions do
        local other = collisions[i]
        
        if other:isa(Flashlight) then
            self:subtractHealth()
        end
    end
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