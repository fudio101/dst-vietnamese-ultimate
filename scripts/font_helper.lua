-- Font loading helper for VN Combo
local M = {}

-------------------------------------------------------------------
-- setup must be called from modmain AFTER GLOBAL exists
-------------------------------------------------------------------
function M.setup(selectedLanguage, MODROOT, modname, _G)
    local TheSim = _G.TheSim

    ---------------------------------------------------------------
    -- 1. Build font-name list
    ---------------------------------------------------------------
    local FontNames = require("fonts_list") -- base path scripts/
    local list      = {}
    for _, fname in ipairs(FontNames) do list[fname] = true end

    -- add dynamic NEWFONT variants
    if _G.rawget(_G, "NEWFONT") then list["spirequal"] = true end
    if _G.rawget(_G, "NEWFONT_SMALL") then list["spirequal_small"] = true end
    if _G.rawget(_G, "NEWFONT_OUTLINE") then list["spirequal_outline"] = true end
    if _G.rawget(_G, "NEWFONT_OUTLINE_SMALL") then list["spirequal_outline_small"] = true end

    ---------------------------------------------------------------
    -- 2. Cache originals once per session
    ---------------------------------------------------------------
    if not M._orig then
        local originals = {}
        for _, k in ipairs {
            "DEFAULTFONT", "DIALOGFONT", "TITLEFONT", "UIFONT", "BUTTONFONT",
            "HEADERFONT", "CHATFONT", "CHATFONT_OUTLINE", "NUMBERFONT", "TALKINGFONT",
            "SMALLNUMBERFONT", "BODYTEXTFONT", "TALKINGFONT_WORMWOOD",
            "TALKINGFONT_HERMIT", "CODEFONT", "NEWFONT", "NEWFONT_SMALL",
            "NEWFONT_OUTLINE", "NEWFONT_OUTLINE_SMALL"
        } do
            originals[k] = _G.rawget(_G, k)
        end
        M._orig = originals
    end
    local OriginalFonts = M._orig

    ---------------------------------------------------------------
    -- 3. Hàm thực thi chính
    ---------------------------------------------------------------
    local function Apply()
        -- restore originals (nếu load lại)
        for k, v in pairs(OriginalFonts) do _G[k] = v end

        -- unload cũ
        for fname in pairs(list) do TheSim:UnloadFont(selectedLanguage .. "_" .. fname) end
        TheSim:UnloadPrefabs({ selectedLanguage .. "_fonts_" .. modname })

        -- assets & prefab
        local assets = {}
        for fname in pairs(list) do
            table.insert(assets, _G.Asset("FONT",
                MODROOT .. "fonts/" .. fname .. "__" .. selectedLanguage .. ".zip"))
        end
        local pf = _G.Prefab("common/" .. selectedLanguage .. "_fonts_" .. modname, nil, assets)
        if _G.RegisterPrefabs then _G.RegisterPrefabs(pf) end
        TheSim:LoadPrefabs({ selectedLanguage .. "_fonts_" .. modname })
        for fname in pairs(list) do
            TheSim:LoadFont(MODROOT .. "fonts/" .. fname .. "__" .. selectedLanguage .. ".zip",
                selectedLanguage .. "_" .. fname)
        end

        -- alias
        _G.DEFAULTFONT          = selectedLanguage .. "_opensans50"
        _G.DIALOGFONT           = selectedLanguage .. "_opensans50"
        _G.TITLEFONT            = selectedLanguage .. "_belisaplumilla100"
        _G.UIFONT               = selectedLanguage .. "_belisaplumilla50"
        _G.BUTTONFONT           = selectedLanguage .. "_buttonfont"
        _G.HEADERFONT           = selectedLanguage .. "_hammerhead50"
        _G.CHATFONT             = selectedLanguage .. "_bellefair50"
        _G.CHATFONT_OUTLINE     = selectedLanguage .. "_bellefair_outline50"
        _G.NUMBERFONT           = selectedLanguage .. "_stint-ucr50"
        _G.TALKINGFONT          = selectedLanguage .. "_talkingfont"
        _G.SMALLNUMBERFONT      = selectedLanguage .. "_stint-ucr20"
        _G.BODYTEXTFONT         = selectedLanguage .. "_stint-ucr50"
        _G.TALKINGFONT_WORMWOOD = selectedLanguage .. "_talkingfont_wormwood"
        _G.TALKINGFONT_HERMIT   = selectedLanguage .. "_talkingfont_hermit"
        _G.CODEFONT             = selectedLanguage .. "_opensans50"
        if OriginalFonts.NEWFONT then _G.NEWFONT = selectedLanguage .. "_spirequal" end
        if OriginalFonts.NEWFONT_SMALL then _G.NEWFONT_SMALL = selectedLanguage .. "_spirequal_small" end
        if OriginalFonts.NEWFONT_OUTLINE then _G.NEWFONT_OUTLINE = selectedLanguage .. "_spirequal_outline" end
        if OriginalFonts.NEWFONT_OUTLINE_SMALL then _G.NEWFONT_OUTLINE_SMALL = selectedLanguage ..
            "_spirequal_outline_small" end
    end

    M.apply = Apply
end

return M
