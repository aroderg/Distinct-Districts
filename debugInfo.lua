debugInfo = {}
function debugInfo.show()
    love.graphics.setFont(fonts.AfacadFluxBold20)
    local entryNames = {"next district cost", "next miner cost"}
    local valueNames = {districts.costs[districts.calculateCells() + 1], miners.costs[#cellMiners + 1]}
    for i=1,2 do
        love.graphics.printf(entryNames[i] .. ":" .. valueNames[i], 220, -16 + i*24, 1920, "left")
    end
end