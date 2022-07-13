import "Corelibs/object"
import "Corelibs/graphics"
import "Corelibs/sprites"
import "Corelibs/animator"
import "Corelibs/animation"
import "Corelibs/timer"
import "Corelibs/ui"
import "External/AnimatedSprite"

import "player"
import "enemy"

local pd <const> = playdate
local gfx <const> = pd.graphics
local font = gfx.font.new('font/Mini Sans 2X') -- DEMO

local function loadGame()
    local backgroundImage = gfx.image.new("Images/background")
    gfx.sprite.setBackgroundDrawingCallback(
        function(x,y,width,height)
            backgroundImage:draw(0,0)
        end
    )
    
    Player(200, 120)
    gfx.setFont(font) -- DEMO
end

local function spawnEnemy()
    pd.timer.new(1000, function()
        local directions = {"north", "east", "west", "south"}
        local enemyDirection = directions[math.random(4)]
                
        if enemyDirection == "north" then
            Enemy(math.random(0, 400), 240, enemyDirection)
        elseif enemyDirection == "south" then
            Enemy(math.random(0, 400), 15, enemyDirection)
        elseif enemyDirection == "east" then
            Enemy(15, math.random(0, 240), enemyDirection)
        elseif enemyDirection == "west" then
            Enemy(400, math.random(0, 240), enemyDirection)
        end

        spawnEnemy()
    end)
end

loadGame()
spawnEnemy()

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
    -- pd.drawFPS(0,0) -- FPS widget
    pd.ui.crankIndicator:start()
    
    if pd.isCrankDocked() then
        playdate.ui.crankIndicator:update()
    end
end