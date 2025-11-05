function loadGameState()
    gameState = {}
    gameState.screen = "mapSelection"
    gameState.currentMapSelected = 1
    gameState.availableMaps = {"square", "eatenSquare"}
    gameState.animations = {}
    gameState.animations.mapSelect = 0.4
    gameState.animations.mapSelectDirection = 1
    gameState.map = {}
    gameState.map.width = 15
    gameState.map.height = 15
    gameState.map.emptyCellFrequency = 0.5
    gameState.map.resourceWeights = {80, 6, 0.5, 0.5, 0.5}
end