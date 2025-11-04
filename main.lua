moonshine = require "moonshine"
map = require "maps"

function love.load()
    cellColors = {
        {0, 0, 0, 1}, --black
        {1, 0, 0, 1}, --red
        {1, 0.5, 0, 1}, --orange
        {1, 1, 0, 1}, --yellow
        {0.5, 1, 0, 1}, --lime
        {0, 1, 0, 1}, --green
        {0, 1, 0.5, 1}, --ocean
        {0, 1, 1, 1}, --cyan
        {0, 0.5, 1, 1}, --blue
        {0, 0, 1, 1}, --deep blue
        {0.5, 0, 1, 1}, --purple
        {1, 0, 1, 1}, --pink
        {1, 1, 1, 1}, --white
    }
    gameState = {}
    gameState.screen = "mapSelection"
    gameState.animations = {}
    gameState.animations.mapSelect = 0
    gameState.map = maps.square
    fonts = {}
    fonts.AfacadFlux48 = love.graphics.newFont("fonts/Afacad Flux/AfacadFlux-Regular.ttf", 48)
end

function love.draw()
    if gameState == "mapSelection" then
        love.graphics.print("Select a map to start the game!", 0, 100, 1920, "center")
    elseif gameState ~= "mapSelection" then
        love.graphics.setLineWidth(1)
        love.graphics.setLineStyle("rough")
        local mainUIChain = moonshine.chain(moonshine.effects.gaussianblur)
        mainUIChain.gaussianblur.sigma = 8
        love.graphics.setColor(1, 1, 1, 1)
        local GRID_SIZE = 800
        local CELL_SIZE = GRID_SIZE / math.max(MAPWIDTH, MAPHEIGHT)
        -- mainUIChain.draw(function()
        --     for i,v in ipairs(gameState.map) do
        --         for j,w in ipairs(v) do
        --         local color = w ~= 0 and cellColors[w] or {1, 1, 1, 0}
        --         --love.graphics.rectangle("line", 600 + 90 * j, 170 + 90 * i, 90, 90)
        --         love.graphics.setColor(color)
        --         love.graphics.rectangle("fill", (960 - CELL_SIZE * MAPWIDTH / 2) + CELL_SIZE * (j - 1) + CELL_SIZE * 0.35, (540 - CELL_SIZE * MAPHEIGHT / 2) + CELL_SIZE * (i - 1) + CELL_SIZE * 0.35, CELL_SIZE * 0.3, CELL_SIZE * 0.3)
        --         end
        --     end
        -- end)
        for i,v in ipairs(gameState.map) do
            for j,w in ipairs(v) do 
                local color = w == 0 and {1, 1, 1, 0} or cellColors[w]
                love.graphics.setColor(color)
                love.graphics.rectangle("fill", (960 - CELL_SIZE * MAPWIDTH / 2) + CELL_SIZE * (j - 1) + CELL_SIZE * 0.35, (540 - CELL_SIZE * MAPHEIGHT / 2) + CELL_SIZE * (i - 1) + CELL_SIZE * 0.35, CELL_SIZE * 0.3, CELL_SIZE * 0.3)
            end
        end
        for i,v in ipairs(gameState.map) do
            for j,w in ipairs(v) do
                local color = w == 0 and {1, 1, 1, 0} or {1, 1, 1, 1}
                love.graphics.setColor(color)
                love.graphics.rectangle("line", (960 - CELL_SIZE * MAPWIDTH / 2) + CELL_SIZE * (j - 1), (540 - CELL_SIZE * MAPHEIGHT / 2) + CELL_SIZE * (i - 1), CELL_SIZE, CELL_SIZE)
            end
        end
    end
end

function love.update(dt)
    
end