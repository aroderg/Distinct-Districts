function loadGameState()
    gameState = {}
    gameState.screen = "mapSelection"
    gameState.animations = {}
    gameState.animations.mapSelect = 0
    gameState.currentMapSelected = "square"
    gameState.map = {}
    gameState.map.width = 15
    gameState.map.height = 15
    gameState.map.emptyCellFrequency = 0.5
    gameState.map.resourceWeights = {80, 6, 0.5, 0.5, 0.5}
end