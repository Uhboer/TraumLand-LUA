function love.load()
    anim8 = require 'libraries/anim8' 

    sti = require 'libraries/sti' 

    gameMap = sti('maps/test.lua')

    -- disable smooth for a scaling pixels (maybe i need that tomorrow)
    love.graphics.setDefaultFilter('nearest', 'nearest')

    player = {}
    player.x = 400
    player.y = 200
    player.scale_x = 1
    player.scale_y = 1
    player.origin_x, player.origin_y = 32, 32

    player.speed = 5


    player.spritetorso = love.graphics.newImage('sprites/humanity/torso.png')
    player.spritehead = love.graphics.newImage('sprites/humanity/head.png')
    player.spritelarm = love.graphics.newImage('sprites/humanity/l_arm.png')
    player.spriterarm = love.graphics.newImage('sprites/humanity/r_arm.png')
    player.spritelleg = love.graphics.newImage('sprites/humanity/l_leg.png')
    player.spriterleg = love.graphics.newImage('sprites/humanity/r_leg.png')
    player.spritesheetlleg = love.graphics.newImage('sprites/humanity/human_walkl1-Sheet.png')
    player.spritesheetrleg = love.graphics.newImage('sprites/humanity/human_walkr1-Sheet.png')

    player.grid = anim8.newGrid(64, 64, player.spritesheetlleg:getWidth(), player.spritesheetlleg:getHeight())

    player.animations = {}
    player.animations.lleg = anim8.newAnimation(player.grid('1-7', 1), 0.1 )
    player.animations.rleg = anim8.newAnimation(player.grid('1-7', 1), 0.1 )


    background = love.graphics.newImage('sprites/find_your_way.png')
end


function love.update(dt)
    local isMoving = false

    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed
        player.scale_x = 1
        isMoving = true
    end

    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed
        player.scale_x = -1
        isMoving = true
    end

    if love.keyboard.isDown("w") then
        player.y = player.y - player.speed
        isMoving = true
    end

    if love.keyboard.isDown("s") then
        player.y = player.y + player.speed
        isMoving = true
    end

    if isMoving == false then
        player.animations.lleg:gotoFrame(1)
        player.animations.rleg:gotoFrame(1)
    end


    player.animations.lleg:update(dt)
    player.animations.rleg:update(dt)
end


function love.draw()
    love.graphics.draw(background, 0, 0, 0, 1.2, 1.2)
    gameMap:draw()
    --player
    love.graphics.draw(player.spritetorso, player.x, player.y, 0, player.scale_x, player.scale_y, player.origin_x, player.origin_y)
    love.graphics.draw(player.spritehead, player.x, player.y, 0, player.scale_x, player.scale_y, player.origin_x, player.origin_y)
    love.graphics.draw(player.spriterarm, player.x, player.y, 0, player.scale_x, player.scale_y, player.origin_x, player.origin_y)
    love.graphics.draw(player.spritelarm, player.x, player.y, 0, player.scale_x, player.scale_y, player.origin_x, player.origin_y)
--    love.graphics.draw(player.spriterleg, player.x, player.y, 0, player.scale_x, player.scale_y, player.origin_x, player.origin_y)
--    love.graphics.draw(player.spritelleg, player.x, player.y, 0, player.scale_x, player.scale_y, player.origin_x, player.origin_y)

    player.animations.lleg:draw(player.spritesheetlleg, player.x, player.y, 0, player.scale_x, player.scale_y, player.origin_x, player.origin_y)
    player.animations.rleg:draw(player.spritesheetrleg, player.x, player.y, 0, player.scale_x, player.scale_y, player.origin_x, player.origin_y)

end