--[[
VN Combo ModMain – kết hợp Việt hoá giao diện, Announcer và Skill-Tree
--]]

local mainPOfilename   = "./vietnamese.po"   -- file .po ở thư mục mod
local selectedLanguage = "vi"

-- Tải bản dịch
LoadPOFile(mainPOfilename, selectedLanguage)

--------------------------------------------------------------------
-- Khai báo tiện ----------------------------------------------------
--------------------------------------------------------------------
local _G      = GLOBAL
local TheSim  = _G.TheSim
local MODROOT = MODROOT
local modname = modname

--------------------------------------------------------------------
-- Nạp & áp dụng font tiếng Việt -----------------------------------
--------------------------------------------------------------------
local OriginalFonts = {}
for _, k in ipairs({"DEFAULTFONT","DIALOGFONT","TITLEFONT","UIFONT","BUTTONFONT","HEADERFONT","CHATFONT","CHATFONT_OUTLINE","NUMBERFONT","TALKINGFONT","SMALLNUMBERFONT","BODYTEXTFONT","TALKINGFONT_WORMWOOD","TALKINGFONT_HERMIT","CODEFONT","NEWFONT","NEWFONT_SMALL","NEWFONT_OUTLINE","NEWFONT_OUTLINE_SMALL"}) do
    OriginalFonts[k] = _G.rawget(_G, k)
end

local function ApplyLocalizedFonts()
    local list = {
        ["talkingfont"]              = true,
        ["talkingfont_hermit"]      = true,
        ["talkingfont_wormwood"]    = true,
        ["stint-ucr50"]             = true,
        ["stint-ucr20"]             = true,
        ["opensans50"]              = true,
        ["belisaplumilla50"]        = true,
        ["belisaplumilla100"]       = true,
        ["buttonfont"]              = true,
        ["hammerhead50"]            = true,
        ["bellefair50"]             = true,
        ["bellefair_outline50"]     = true,
        ["spirequal"]               = _G.rawget(_G,"NEWFONT") and true or nil,
        ["spirequal_small"]         = _G.rawget(_G,"NEWFONT_SMALL") and true or nil,
        ["spirequal_outline"]       = _G.rawget(_G,"NEWFONT_OUTLINE") and true or nil,
        ["spirequal_outline_small"] = _G.rawget(_G,"NEWFONT_OUTLINE_SMALL") and true or nil,
    }

    -- Khôi phục font gốc nếu cần
    for k,v in pairs(OriginalFonts) do _G[k] = v end

    -- Unload trước nếu đã load
    for fname in pairs(list) do TheSim:UnloadFont(selectedLanguage.."_"..fname) end
    TheSim:UnloadPrefabs({selectedLanguage.."_fonts_"..modname})

    -- Tạo asset & prefab
    local assets = {}
    for fname in pairs(list) do
        table.insert(assets, Asset("FONT", MODROOT.."fonts/"..fname.."__"..selectedLanguage..".zip"))
    end
    local pf = Prefab("common/"..selectedLanguage.."_fonts_"..modname, nil, assets)
    if _G.RegisterPrefabs then _G.RegisterPrefabs(pf) end
    TheSim:LoadPrefabs({selectedLanguage.."_fonts_"..modname})
    for fname in pairs(list) do
        TheSim:LoadFont(MODROOT.."fonts/"..fname.."__"..selectedLanguage..".zip", selectedLanguage.."_"..fname)
    end

    -- Gán alias font
    _G.DEFAULTFONT           = selectedLanguage.."_opensans50"
    _G.DIALOGFONT            = selectedLanguage.."_opensans50"
    _G.TITLEFONT             = selectedLanguage.."_belisaplumilla100"
    _G.UIFONT                = selectedLanguage.."_belisaplumilla50"
    _G.BUTTONFONT            = selectedLanguage.."_buttonfont"
    _G.HEADERFONT            = selectedLanguage.."_hammerhead50"
    _G.CHATFONT              = selectedLanguage.."_bellefair50"
    _G.CHATFONT_OUTLINE      = selectedLanguage.."_bellefair_outline50"
    _G.NUMBERFONT            = selectedLanguage.."_stint-ucr50"
    _G.TALKINGFONT           = selectedLanguage.."_talkingfont"
    _G.SMALLNUMBERFONT       = selectedLanguage.."_stint-ucr20"
    _G.BODYTEXTFONT          = selectedLanguage.."_stint-ucr50"
    _G.TALKINGFONT_WORMWOOD  = selectedLanguage.."_talkingfont_wormwood"
    _G.TALKINGFONT_HERMIT    = selectedLanguage.."_talkingfont_hermit"
    _G.CODEFONT              = selectedLanguage.."_opensans50"
    if OriginalFonts.NEWFONT then _G.NEWFONT = selectedLanguage.."_spirequal" end
    if OriginalFonts.NEWFONT_SMALL then _G.NEWFONT_SMALL = selectedLanguage.."_spirequal_small" end
    if OriginalFonts.NEWFONT_OUTLINE then _G.NEWFONT_OUTLINE = selectedLanguage.."_spirequal_outline" end
    if OriginalFonts.NEWFONT_OUTLINE_SMALL then _G.NEWFONT_OUTLINE_SMALL = selectedLanguage.."_spirequal_outline_small" end
end

-- Gắn vào vòng đời game
local OldRegisterPrefabs = _G.ModManager.RegisterPrefabs
_G.ModManager.RegisterPrefabs = function(self)
    OldRegisterPrefabs(self)
    ApplyLocalizedFonts()
end
local OldStart = _G.Start
_G.Start = function()
    ApplyLocalizedFonts()
    OldStart()
end

--------------------------------------------------------------------
-- Announcer Translation Hook --------------------------------------
--------------------------------------------------------------------
local STRINGS     = _G.STRINGS
local DICTIONARY  = {}
local STRINGS_NEW = _G.LanguageTranslator.languages[selectedLanguage] or {}

local function build(node, path)
    for k,v in pairs(node) do
        if type(v)=="table" then build(v, path.."."..k) else
            local val = STRINGS_NEW[path.."."..k]
            if val then DICTIONARY[v]=val end
        end
    end
end
build(STRINGS,"STRINGS")

if _G.Networking_Talk then
    local oldTalk=_G.Networking_Talk
    _G.Networking_Talk=function(guid,msg,...)
        oldTalk(guid, DICTIONARY[msg] or msg, ...)
    end
end

--------------------------------------------------------------------
-- Status Announcer ------------------------------------------------
--------------------------------------------------------------------
if GetModConfigData("THONG_BAO_TRANG_THAI") == "On" then
    modimport("scripts/statusannouncer.lua")
end

--------------------------------------------------------------------
-- Skill-Tree Vietnamese Strings -----------------------------------
--------------------------------------------------------------------
modimport("scripts/skilltree_strings.lua") 