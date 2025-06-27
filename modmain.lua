--[[ VN Combo ModMain (thin) ]] --

local mainPOfilename   = "./vietnamese.po"
local selectedLanguage = "vi"
local DEV_MODE         = false

LoadPOFile(mainPOfilename, selectedLanguage)

local font       = require("font_helper")
local translator = require("translator_helper")

local MODROOT    = MODROOT
local modname    = modname

font.setup(selectedLanguage, MODROOT, modname, GLOBAL)
translator.init(selectedLanguage, DEV_MODE, GLOBAL)

-- Lazy load fonts when player joins world
AddPrefabPostInit("world", function(inst)
    inst:ListenForEvent("playeractivated", function() font.apply() end)
end)

if GetModConfigData("THONG_BAO_TRANG_THAI") == "On" then
    modimport("scripts/statusannouncer.lua")
end

modimport("scripts/skilltree_strings.lua")
