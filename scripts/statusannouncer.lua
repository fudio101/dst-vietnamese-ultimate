local GetModuleDefinitionFromNetID = require("wx78_moduledefs").GetModuleDefinitionFromNetID

local WHISPER = false
local WHISPER_ONLY = false
local EXPLICIT = true
local SHOWDURABILITY = true
local SHOWPROTOTYPER = true
local SHOWEMOJI = true

local setters = {
  WHISPER = function(v) WHISPER = v end,
  WHISPER_ONLY = function(v) WHISPER_ONLY = v end,
  EXPLICIT = function(v) EXPLICIT = v end,
  SHOWDURABILITY = function(v) SHOWDURABILITY = v end,
  SHOWPROTOTYPER = function(v) SHOWPROTOTYPER = v end,
  SHOWEMOJI = function(v) SHOWEMOJI = v end,
}

local needs_strings = {
  NEEDSCIENCEMACHINE = "RESEARCHLAB",
  NEEDALCHEMYENGINE = "RESEARCHLAB2",
  NEEDSHADOWMANIPULATOR = "RESEARCHLAB3",
  NEEDPRESTIHATITATOR = "RESEARCHLAB4",
  NEEDSANCIENT_FOUR = "ANCIENT_ALTAR",
}

-- This metatable fallback etc.
