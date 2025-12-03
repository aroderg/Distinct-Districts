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
    gameState.map.resourceWeights = {50, 6, 0.5, 0.5, 0.5}
    gameState.map.minerWeights = {6, 0.5, 0.5, 0.5}
    gameState.resources = {}
    gameState.resources.red = 400
    gameState.resources.orange = 0
    gameState.resources.yellow = 0
    gameState.resources.green = 0
    gameState.placingMiner = false
    gameState.allVisible = false
    gameState.districtExpansion = false
    gameState.districtNames = {}
    gameState.districtToExpand = {index = 1, name = "testD"}
end