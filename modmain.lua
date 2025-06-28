--[[ VN Combo ModMain - Simplified ]] --

local mainPOfilename   = "./vietnamese.po"
local selectedLanguage = "vi"

-- Load Vietnamese translation
LoadPOFile(mainPOfilename, selectedLanguage)

-- Load font system
local font = require("font_helper")
local MODROOT = MODROOT
local modname = modname

font.setup(selectedLanguage, MODROOT, modname, GLOBAL)

-- Lazy load fonts when player joins world
AddPrefabPostInit("world", function(inst)
    inst:ListenForEvent("playeractivated", function() 
        font.apply() 
        print("[VN Combo] Fonts loaded successfully!")
    end)
end)

-- Load skill tree strings
modimport("scripts/skilltree_strings.lua")

print("[VN Combo] Mod initialized - Vietnamese translation + fonts + skill tree")
