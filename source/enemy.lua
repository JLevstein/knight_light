local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(gfx.sprite)

function Enemy:init(x, y, direction)
    self.travelDirection = nil
    self.weakness = nil
    self.health = 100
    self.speed = 1

    self.spritesheet = gfx.imagetable.new("images/enemy")
    local currentSprite = self.spritesheet:getImage(1)
    self:setImage(currentSprite)
    self:moveTo(x, y)
    self:add()

    self:changeDirection(direction)
    -- self:moveWithCollisions(200, 120)
end

function Enemy:changeDirection(newDirection)
    self.travelDirection = newDirection
    
    if newDirection == "north" then
        self:setRotation(180)
        self.weakness = "south"
    elseif newDirection == "south" then
        self.weakness = "north"
    elseif newDirection == "east" then
        self:setRotation(270)
        self.weakness = "west"
    elseif newDirection == "west" then
        self:setRotation(90)
        self.weakness = "east"
    end
    self:setCollideRect(0,0,self:getSize())

    local path = pd.geometry.lineSegment.new(self.x, self.y, 200, 120)
    local anim = gfx.animator.new(4000, path, pd.easingFunctions.linear)

    self:setAnimator(anim, true)
end

function Enemy:update()
    if self.x == 200 and self.y == 120 then
        print("GAME OVER!")
    end
end