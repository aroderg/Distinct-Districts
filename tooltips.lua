function cellTooltips()
    local mx, my = love.mouse.getPosition()
    local GRID_SIZE = 800
    local CELL_SIZE = GRID_SIZE / math.max(gameState.map.width, gameState.map.height)
    for i,v in ipairs(gameState.map.type) do
        for j,w in ipairs(v) do
            if mx >= (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) and mx <= (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) + CELL_SIZE and my >= (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) and my <= (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) + CELL_SIZE then
                local visibilityOverride = w.visible or gameState.allVisible
                if w.resource ~= 0 then
                    local tooltip = {x = (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 0.5) - 140, y = (540 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (i - 1) - CELL_SIZE - 20}
                    local minerNames = {"red", "orange", "yellow", "green"}
                    love.graphics.setColor(1, 1, 1, 1)
                    love.graphics.rectangle("fill", tooltip.x, tooltip.y, 280, 73)
                    love.graphics.setFont(fonts.Vera12)
                    love.graphics.setColor(0, 0, 0, 1)
                    love.graphics.printf(
                    "District Expansion: " .. (gameState.districtExpansion and "ON" or "OFF") .. "\n" ..
                    "Placing Miners: " .. (gameState.placingMiner and "ON" or "OFF") .. "\n" ..
                    "Press < and > to rotate between Districts." .. "\n" ..
                    "Current District: " .. gameState.districtToExpand.name .. "\n" ..
                    "Current Miner: " .. minerNames[gameState.minerToPlace],
                    math.floor(tooltip.x), math.floor(tooltip.y), 280, "center")
                end
                --break
            end
        end
    end
end