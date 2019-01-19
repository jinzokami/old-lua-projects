level_dir = "levels/"

LEVEL_1 = {}
LEVEL_1.map = require(level_dir.."level-1")

LEVEL_2 = {}
LEVEL_2.map = require(level_dir.."level-2")

LEVEL_3 = {}
LEVEL_3.map = require(level_dir.."level-3")

LEVEL_1.onComplete = function() changeLevels(LEVEL_2) end
LEVEL_2.onComplete = function() changeLevels(LEVEL_3) end
LEVEL_3.onComplete = function() changeLevels(LEVEL_1) end