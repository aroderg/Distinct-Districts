miners = {}
cellMiners = {}
miners.costs = {}
local minerCost = 10
table.insert(miners.costs, 0)
for i=1,100 do
    table.insert(miners.costs, minerCost)
    minerCost = minerCost * 2
end
function miners.create(coordinates, miningResource, miningSpeed)
    local newMiner = {}
    newMiner.coordinates = coordinates
    newMiner.resource = miningResource
    newMiner.miningQuantity = miningSpeed
    newMiner.timer_mining = 0
    table.insert(cellMiners, newMiner)
    return true
end

function miners.scan(coordinates)
    local minerFound = false
    for i,v in pairs(cellMiners) do
        if v.coordinates[1] == coordinates[1] and v.coordinates[2] == coordinates[2] then
            minerFound = true
        end
    end
    return minerFound
end