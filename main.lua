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
            mainUIChain.gaussianblur.sigma = 4
            if gameState.currentMapSelected ~= 1 then
                love.graphics.printf("<", 625, 205, 80, "center")
            elseif gameState.currentMapSelected ~= 2 then
                love.graphics.printf(">", 1215, 205, 80, "center")
            end
        end)
        love.graphics.printf("Select a map to start the game!", 0, 100, 1920, "center")
        love.graphics.setScissor(705, 205, 510, 80)
        love.graphics.printf(gameState.availableMaps[gameState.currentMapSelected], 0, 200, 1920, "center")
        love.graphics.setScissor()
        love.graphics.setLineWidth(4)
        if gameState.currentMapSelected ~= 1 then
            love.graphics.rectangle("line", 625, 205, 80, 80, 6, 6)
            love.graphics.printf("<", 625, 205, 80, "center")
        elseif gameState.currentMapSelected ~= 2 then
            love.graphics.rectangle("line", 1215, 205, 80, 80, 6, 6)
            love.graphics.printf(">", 1215, 205, 80, "center")
        end
        love.graphics.rectangle("line", 860, 360, 200, 80, 6, 6)
        love.graphics.printf("Done", 860, 358, 200, "center")
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
                local cellColor = w == 0 and {1, 1, 1, 0} or cellColors[w]
                love.graphics.setColor(cellColor)
                love.graphics.rectangle("fill", (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) + CELL_SIZE * 0.35, (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) + CELL_SIZE * 0.35, CELL_SIZE * 0.3, CELL_SIZE * 0.3)
            end
        end
        for i,v in ipairs(gameState.map.type) do
            for j,w in ipairs(v) do
                local borderColor = w == 0 and {1, 1, 1, 0} or {1, 1, 1, 1}
                love.graphics.setColor(borderColor)
                love.graphics.rectangle("line", (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1), (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1), CELL_SIZE, CELL_SIZE)
            end
        end
    end
end

function love.update(dt)
    -- if gameState.animations.mapSelect < 0.4 then
    --     gameState.animations.mapSelect = math.min(gameState.animations.mapSelect + dt, 0.4)
    -- else
    --     gameState.animations.mapSelect = 0.4
    -- end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        if gameState.screen == "mapSelection" then
            if x >= 625 and y >= 205 and x <= 705 and y <= 285 and gameState.currentMapSelected == 2 then
                gameState.currentMapSelected = 1
                gameState.animations.mapSelect = 0
                gameState.animations.mapSelectDirection = 1
            elseif x >= 1215 and y >= 205 and x <= 1295 and y <= 285 and gameState.currentMapSelected == 1 then
                gameState.currentMapSelected = 2
                gameState.animations.mapSelect = 0
                gameState.animations.mapSelectDirection = -1
            elseif x >= 860 and y >= 360 and x <= 1060 and y <= 440 then
                gameState.screen = "game"
                maps.square = maps.load.square(gameState.map.width, gameState.map.height)
                local mapToLoad = gameState.availableMaps[gameState.currentMapSelected]
                maps.square = maps.load.square(gameState.map.width, gameState.map.height)
                maps.eatenSquare = maps.load.eatenSquare(gameState.map.width, gameState.map.height)
                gameState.map.type = maps[mapToLoad]
            end
        end
    end
end