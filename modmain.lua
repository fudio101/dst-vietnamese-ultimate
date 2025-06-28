--[[ DST Việt hoá Ultimate - Main Module ]] --

local MOD_NAME = "DST Việt hoá Ultimate"
local selectedLanguage = "vi"

-- Load Vietnamese translation
LoadPOFile("./vietnamese.po", selectedLanguage)
print("[" .. MOD_NAME .. "] Vietnamese translation loaded")

-- Load font system
local font = require("font_helper")
font.setup(selectedLanguage, MODROOT, modname, GLOBAL)

-- Load fonts when player joins world (only once per session)
local fonts_loaded = false
AddPrefabPostInit("world", function(inst)
    inst:ListenForEvent("playeractivated", function()
        if not fonts_loaded then
            font.apply()
            fonts_loaded = true
            print("[" .. MOD_NAME .. "] Fonts applied successfully")
        end
    end)
end)

-- Load skill tree strings
modimport("scripts/skilltree_strings.lua")

print("[" .. MOD_NAME .. "] Initialization complete! 🇻🇳")
