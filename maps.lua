maps = {}
maps.load = {}

function lootTable(weights)
    local weightPicked = 0
    local totalWeight = 0
    local weightLeftToDraw = 0
    for _,v in pairs(weights) do
        totalWeight = totalWeight + v
    end
    weightLeftToDraw = totalWeight * love.math.random()
    for _,v in pairs(weights) do
        weightLeftToDraw = weightLeftToDraw - v
        if weightLeftToDraw <= 0 then
            return _
        end
    end
end

function maps.load.square(width, height)
    local map = {}
    for i=1,height do
        table.insert(map, {})
        for j=1,width do
            table.insert(map[i], {
                resource = lootTable(gameState.map.resourceWeights),
                visible = false
            })
        end
    end
    return map
end

function maps.load.eatenSquare(width, height)
    gameState.map.emptyCellFrequency = 0.5
    local map = {}
    for i=1,height do
        table.insert(map, {})
        for j=1,width do
            local toInsert = love.math.random()
            if toInsert <= (1 - gameState.map.emptyCellFrequency) then
            table.insert(map[i], {
                resource = lootTable(gameState.map.resourceWeights),
                visible = false
            })
            else
                table.insert(map[i], {
                resource = lootTable({[0] = 100}),
            })
            end
        end
    end
    return map
end

function maps.revealOneCell()
    local NoOfResCells = 0
    local resCellsLocations = {}
    for i,v in ipairs(gameState.map.type) do
        for j,w in ipairs(v) do
            if w.resource == 2 then
                NoOfResCells = NoOfResCells + 1
                table.insert(resCellsLocations, {j, i})
            end
        end
    end
    local cellToReveal = love.math.random(1, NoOfResCells)
    local cellToReveal_pos = resCellsLocations[cellToReveal]
    gameState.map.type[cellToReveal_pos[2]][cellToReveal_pos[1]].visible = true
    return true
end