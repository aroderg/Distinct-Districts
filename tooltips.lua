function cellTooltips()
    local mx, my = love.mouse.getPosition()
    local GRID_SIZE = 800
    local CELL_SIZE = GRID_SIZE / math.max(gameState.map.width, gameState.map.height)
    for i,v in ipairs(gameState.map.type) do
        for j,w in ipairs(v) do
            if mx >= (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) and mx <= (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) + CELL_SIZE and my >= (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) and my <= (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) + CELL_SIZE then
                local visibilityOverride = w.visible or gameState.allVisible
                --if w.resource ~= 1 and visibilityOverride then
                    local tooltip = {x = (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 0.5) - 140, y = (540 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (i - 1) - CELL_SIZE}
                    love.graphics.setColor(1, 1, 1, 1)
                    love.graphics.rectangle("fill", tooltip.x, tooltip.y, 280, 50)
                    love.graphics.setFont(fonts.Vera12)
                    love.graphics.setColor(0, 0, 0, 1)
                    love.graphics.printf("Press D to " .. (gameState.districtExpansion and "de" or "") ..
                    "activate District Expansion.\nPress P to " ..
                    (gameState.placingMiner and "stop" or "start") ..
                    " placing Miners.",
                    math.floor(tooltip.x), math.floor(tooltip.y), 280, "center")
                --end
                --break
            end
        end
    end
end