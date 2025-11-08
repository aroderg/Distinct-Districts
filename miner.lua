miners = {}
function miners.create(coordinates, miningResource, miningSpeed)
    local newMiner = {}
    newMiner.coordinates = coordinates
    newMiner.resource = miningResource
    newMiner.miningQuantity = miningSpeed
    return newMiner
end