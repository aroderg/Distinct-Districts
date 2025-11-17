function cellTooltips()
    local mx, my = love.mouse.getPosition()
    local GRID_SIZE = 800
    local CELL_SIZE = GRID_SIZE / math.max(gameState.map.width, gameState.map.height)
    for i,v in ipairs(gameState.map.type) do
        for j,w in ipairs(v) do
            if mx >= (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) and mx <= (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1) + CELL_SIZE and my >= (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) and my <= (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1) + CELL_SIZE then
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.rectangle("fill", (960 - CELL_SIZE * gameState.map.width / 2) + CELL_SIZE * (j - 1), (540 - CELL_SIZE * gameState.map.height / 2) + CELL_SIZE * (i - 1), 10, 10)
            end
        end
    end
end