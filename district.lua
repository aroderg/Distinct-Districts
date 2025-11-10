districts = {}
storedDistricts = {}
cellDistricts = {}
function districts.create(name, color)
    local newDistrict = {}
    newDistrict.name = name
    newDistrict.cellsOccupied = {}
    newDistrict.color = color
    storedDistricts[name] = newDistrict
    return true
end

function districts.expand(district, cell)
    table.insert(district.cellsOccupied, cell)
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