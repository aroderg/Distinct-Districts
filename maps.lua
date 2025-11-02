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
            table.insert(map[i], lootTable({90, 2.5, 2.5, 2.5, 2.5}))
        end
    end
    return map
end

maps.square = maps.load.square(4, 3)