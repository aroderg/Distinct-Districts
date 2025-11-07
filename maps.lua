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
                resource = lootTable(gameState.map.resourceWeights)
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
                table.insert(map[i], lootTable(gameState.map.resourceWeights))
            else
                table.insert(map[i], lootTable({[0] = 100}))
            end
        end
    end
    return map
end