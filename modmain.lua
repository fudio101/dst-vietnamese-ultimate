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
    -- Load và setup announce strings cho tiếng Việt
    local language = GetModConfigData("LANGUAGE") or "vietnam"
    if language == "detect" then
        -- Tự động phát hiện ngôn ngữ dựa trên setting game
        language = "vietnam" -- Mặc định tiếng Việt
    end
    
    -- Import announce strings theo ngôn ngữ
    if language == "vietnam" then
        modimport("announcestrings/vietnam.lua")
    else
        modimport("announcestrings/english.lua")
    end
    
    -- Gán ANNOUNCE_STRINGS vào STRINGS._STATUS_ANNOUNCEMENTS
    if ANNOUNCE_STRINGS then
        GLOBAL.STRINGS._STATUS_ANNOUNCEMENTS = ANNOUNCE_STRINGS
    end
    
    -- Load status announcer
    modimport("scripts/statusannouncer.lua")
end

modimport("scripts/skilltree_strings.lua")
