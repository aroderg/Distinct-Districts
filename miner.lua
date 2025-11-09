miners = {}
cellMiners = {}
function miners.create(coordinates, miningResource, miningSpeed)
    local newMiner = {}
    newMiner.coordinates = coordinates
    newMiner.resource = miningResource
    newMiner.miningQuantity = miningSpeed
    newMiner.timer_mining = 0
    table.insert(cellMiners, newMiner)
    return true
end