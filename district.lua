districts = {}
storedDistricts = {}
cellDistricts = {}
function districts.reloadCosts()
    districts.costs = {}
    for i=1,gameState.map.width*gameState.map.height do
        table.insert(districts.costs, i +3)
    end
end
function districts.create(name, color)
    local newDistrict = {}
    newDistrict.name = name
    newDistrict.cellsOccupied = {}
    newDistrict.occupiedCells = 0
    newDistrict.color = color
    storedDistricts[name] = newDistrict
    return true
end

function districts.expand(district, cell)
    table.insert(district.cellsOccupied, cell)
    district.occupiedCells = district.occupiedCells + 1
    return district
end

function districts.scan(coordinates)
    local districtFound = false
    for i,v in pairs(storedDistricts) do
        for j,w in ipairs(v.cellsOccupied) do
            if w[1] == coordinates[1] and w[2] == coordinates[2] then
                districtFound = true
            end
        end
    end
    return districtFound
end

function districts.calculateCells()
    local cellsOccupiedByAll = 0
    for i,v in pairs(storedDistricts) do
        cellsOccupiedByAll = cellsOccupiedByAll + v.occupiedCells
    end
    return cellsOccupiedByAll
end