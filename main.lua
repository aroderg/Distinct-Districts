
moonshine = require "moonshine"
require "gameState"
require "miner"
require "maps"
require "district"
require "debugInfo"
require "tooltips"

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
    fonts.AfacadFluxBold32 = love.graphics.newFont("fonts/Afacad Flux/AfacadFlux-Bold.ttf", 32)
    fonts.AfacadFluxBold20 = love.graphics.newFont("fonts/Afacad Flux/AfacadFlux-Bold.ttf", 20)
    fonts.Vera12 = love.graphics.newFont("fonts/Vera/Vera.ttf", 12)
    districts.create("Wretarne", {0, 1, 0.5, 0.25})
    districts.create("Serrutatarn", {0, 1, 1, 0.25})
    districts.create("Kithajar", {1, 0, 1, 0.25})
    districts.resetEquipped()
    districts.reloadCosts()
end

function love.draw()
    if gameState.screen == "mapSelection" then
        local mainUIChain = moonshine.chain(moonshine.effects.gaussianblur)
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
        mainUIChain.gaussianblur.sigma = 5
        love.graphics.setColor(1, 1, 1, 1)
        local GRID_SIZE = 800
        local CELL_SIZE = GRID_SIZE / math.max(gameState.map.width, gameState.map.height)
        mainUIChain.draw(function()
            for i,v in ipairs(gameState.map.type) do
                for j,w in ipairs(v) do
                    local visibilityOverride = w.visible or gameState.allVisible
                    local cellColor = (w.resource == 0 or w.resource == 1 or not visibilityOverride) and {1, 1, 1, 0} or cellColors[w.resource]
                    love.graphics.setColor(cellColor)
                    love.graphics.rectangle("fill", (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) + CELL_SIZE * 0.35, (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) + CELL_SIZE * 0.35, CELL_SIZE * 0.3, CELL_SIZE * 0.3)
                    local borderColor = w.resource == 0 and {1, 1, 1, 0} or {1, 1, 1, 1}
                    love.graphics.setColor(borderColor)
                    love.graphics.rectangle("line", (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1), (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1), CELL_SIZE, CELL_SIZE)

                end
            end
        end)
        for i,v in pairs(storedDistricts) do
            for j,w in ipairs(v.cellsOccupied) do
                local districtColor = v.color or {1, 1, 1, 1}
                love.graphics.setColor(districtColor)
                love.graphics.rectangle("fill", (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (w[1] - 1), (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (w[2] - 1), CELL_SIZE, CELL_SIZE)
            end
        end
        for i,v in ipairs(gameState.map.type) do
            for j,w in ipairs(v) do
                local visibilityOverride = w.visible or gameState.allVisible
                local cellColor = (w.resource == 0 or w.resource == 1 or not visibilityOverride) and {1, 1, 1, 0} or cellColors[w.resource]
                love.graphics.setColor(cellColor)
                love.graphics.rectangle("fill", (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) + CELL_SIZE * 0.35, (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) + CELL_SIZE * 0.35, CELL_SIZE * 0.3, CELL_SIZE * 0.3)
                local borderColor = w.resource == 0 and {1, 1, 1, 0} or {1, 1, 1, 1}
                love.graphics.setColor(borderColor)
                love.graphics.rectangle("line", (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1), (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1), CELL_SIZE, CELL_SIZE)
            end
        end
        for i,v in ipairs(cellMiners) do
            local minerColor = cellColors[v.resource + 1]
            love.graphics.setColor(minerColor)
            love.graphics.rectangle("line", (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (v.coordinates[1]- 1) + CELL_SIZE * 0.2, (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (v.coordinates[2] - 1) + CELL_SIZE * 0.2, CELL_SIZE * 0.6, CELL_SIZE * 0.6)
        end
        love.graphics.setLineWidth(2)
        love.graphics.setLineStyle("smooth")
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", -10, -10, 220, 400, 9, 9)
        love.graphics.setFont(fonts.AfacadFluxBold32)
        love.graphics.printf("Resources", 0, 0, 210, "center")
        local resourceProcessed = 1
        local resNames = {"red", "orange", "yellow", "green"}
        for i,v in ipairs(resNames) do
            love.graphics.setColor(cellColors[resourceProcessed + 1])
            love.graphics.rectangle("fill", 10, 15 + resourceProcessed * 30, 20, 20)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setFont(fonts.AfacadFluxBold20)
            love.graphics.print(gameState.resources[v], 40, 11 + resourceProcessed * 30)
            resourceProcessed = resourceProcessed + 1
        end
        cellTooltips()
        debugInfo.show()
    end
end

function love.update(dt)
    local resNames = {"red", "orange", "yellow", "green"}
    if screen ~= "mapSelection" then
        for i,v in ipairs(cellMiners) do
            local minerPos = v.coordinates
            if gameState.map.type[minerPos[2]][minerPos[1]].resource == v.resource + 1 then
                v.timer_mining = v.timer_mining + dt
            end
            if v.timer_mining >= 1 then
                v.timer_mining = 0
                local minerRes = resNames[v.resource]
                gameState.resources[minerRes] = gameState.resources[minerRes] + v.miningQuantity
            end
        end
    end
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
                local mapToLoad = gameState.availableMaps[gameState.currentMapSelected]
                gameState.map.type = maps.load[mapToLoad](gameState.map.width, gameState.map.height)
                maps.revealOneCell()
            end
        else
            local GRID_SIZE = 800
            local CELL_SIZE = GRID_SIZE / math.max(gameState.map.width, gameState.map.height)
            local resNames = {"red", "orange", "yellow", "green"}
            for i,v in ipairs(gameState.map.type) do
                for j,w in ipairs(v) do
                    if x >= (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) and x <= (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) + CELL_SIZE and y >= (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) and y <= (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) + CELL_SIZE then
                        if gameState.placingMiner and not miners.scan({j, i}) and districts.scan({j, i}) and gameState.resources.red >= miners.costs[#cellMiners + 1] then
                            gameState.resources.red = gameState.resources.red - miners.costs[#cellMiners + 1]
                            local resToAssignToMiner = gameState.minerToPlace
                            gameState.map.type[i][j].visible = true
                            miners.create({j, i}, resToAssignToMiner, 1)
                        elseif gameState.districtExpansion and not districts.scan({j, i}) and gameState.resources.red >= districts.costs[districts.calculateCells() + 1] then
                            gameState.resources.red = gameState.resources.red - districts.costs[districts.calculateCells() + 1]
                            districts.expand(storedDistricts[gameState.districtToExpand.name], {j, i})
                            gameState.map.type[i][j].visible = true
                        end
                        return true
                    end
                end
            end
        end
    end
end

function love.keypressed(key)
    if gameState.screen ~= "mapSelection" then
        if key == "p" then
            gameState.placingMiner = not gameState.placingMiner
            gameState.districtExpansion = false
        elseif key == "v" then
            gameState.allVisible = not gameState.allVisible
            gameState.placingMiner = false
            gameState.districtExpansion = false
        elseif key == "d" then
            gameState.districtExpansion = not gameState.districtExpansion
            gameState.placingMiner = false
        elseif key == "right" and gameState.districtExpansion then
            districts.rotateEquipped(1)
        elseif key == "left" and gameState.districtExpansion then
            districts.rotateEquipped(-1)
        elseif key == "right" and gameState.placingMiner then
            miners.rotateEquipped(1)
        elseif key == "left" and gameState.placingMiner then
            miners.rotateEquipped(-1)
        end
    end
end