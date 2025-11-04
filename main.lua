moonshine = require "moonshine"
gameState = require "gameState"
map = require "maps"

function love.load()
    cellColors = {
        {0, 0, 0, 1}, --black
        {1, 0, 0, 1}, --red
        {1, 0.5, 0, 1}, --orange
        {1, 1, 0, 1}, --yellow
        {0.5, 1, 0, 1}, --lime
    }
    loadGameState()
    maps.square = maps.load.square(gameState.map.width, gameState.map.height)
    gameState.map.type = maps[gameState.currentMapSelected]
    player = {}
    player.resources = {}
    fonts = {}
    fonts.AfacadFlux60 = love.graphics.newFont("fonts/Afacad Flux/AfacadFlux-Regular.ttf", 60)
end

function love.draw()
    if gameState.screen == "mapSelection" then
        local mainUIChain = moonshine.chain(moonshine.effects.gaussianblur)
        mainUIChain.disable("gaussianblur")
        mainUIChain.draw(function()
            love.graphics.setFont(fonts.AfacadFlux60)
            mainUIChain.enable("gaussianblur")
            mainUIChain.gaussianblur.sigma = 8
            love.graphics.printf("<", 960 - fonts.AfacadFlux60:getWidth(gameState.currentMapSelected) - 20, 205, 80, "center")
            love.graphics.printf(">", 960 + fonts.AfacadFlux60:getWidth(gameState.currentMapSelected) - 60, 205, 80, "center")
        end)
        love.graphics.printf("Select a map to start the game!", 0, 100, 1920, "center")
        love.graphics.printf(gameState.currentMapSelected, 0, 200, 1920, "center")
        love.graphics.setLineWidth(4)
        love.graphics.rectangle("line", 960 + fonts.AfacadFlux60:getWidth(gameState.currentMapSelected) - 60, 205, 80, 80, 6, 6)
        love.graphics.rectangle("line", 960 - fonts.AfacadFlux60:getWidth(gameState.currentMapSelected) - 20, 205, 80, 80, 6, 6)
        love.graphics.printf("<", 960 - fonts.AfacadFlux60:getWidth(gameState.currentMapSelected) - 20, 205, 80, "center")
        love.graphics.printf(">", 960 + fonts.AfacadFlux60:getWidth(gameState.currentMapSelected) - 60, 205, 80, "center")
    else
        love.graphics.setLineWidth(1)
        love.graphics.setLineStyle("rough")
        local mainUIChain = moonshine.chain(moonshine.effects.gaussianblur)
        mainUIChain.gaussianblur.sigma = 8
        love.graphics.setColor(1, 1, 1, 1)
        local GRID_SIZE = 800
        local CELL_SIZE = GRID_SIZE / math.max(gameState.map.width, gameState.map.height)
        -- mainUIChain.draw(function()
        --     for i,v in ipairs(gameState.map) do
        --         for j,w in ipairs(v) do
        --         local color = w ~= 0 and cellColors[w] or {1, 1, 1, 0}
        --         --love.graphics.rectangle("line", 600 + 90 * j, 170 + 90 * i, 90, 90)
        --         love.graphics.setColor(color)
        --         love.graphics.rectangle("fill", (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) + CELL_SIZE * 0.35, (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) + CELL_SIZE * 0.35, CELL_SIZE * 0.3, CELL_SIZE * 0.3)
        --         end
        --     end
        -- end)
        for i,v in ipairs(gameState.map.type) do
            for j,w in ipairs(v) do 
                local color = w == 0 and {1, 1, 1, 0} or cellColors[w]
                love.graphics.setColor(color)
                love.graphics.rectangle("fill", (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) + CELL_SIZE * 0.35, (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) + CELL_SIZE * 0.35, CELL_SIZE * 0.3, CELL_SIZE * 0.3)
            end
        end
        for i,v in ipairs(gameState.map.type) do
            for j,w in ipairs(v) do
                local color = w == 0 and {1, 1, 1, 0} or {1, 1, 1, 1}
                love.graphics.setColor(color)
                love.graphics.rectangle("line", (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1), (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1), CELL_SIZE, CELL_SIZE)
            end
        end
    end
end

function love.update(dt)
    
end