-- Translator helper for VN Combo
local M = {}

function M.init(selectedLanguage, devMode, _G)
    local DICTIONARY
    if devMode then
        DICTIONARY = {}
        local STRINGS_NEW = _G.LanguageTranslator.languages[selectedLanguage] or {}
        local function build(node, path)
            for k, v in pairs(node) do
                if type(v) == "table" then
                    build(v, path .. "." .. k)
                else
                    local val = STRINGS_NEW[path .. "." .. k]
                    if val then DICTIONARY[v] = val end
                end
            end
        end
        build(_G.STRINGS, "STRINGS")
    end

    local function translate(msg)
        if devMode then
            return DICTIONARY[msg] or msg
        else
            return _G.LanguageTranslator:GetTranslation(msg, selectedLanguage) or msg
        end
    end

    if _G.Networking_Talk then
        local oldTalk = _G.Networking_Talk
        _G.Networking_Talk = function(guid, msg, ...)
            oldTalk(guid, translate(msg), ...)
        end
    end
end

return M
