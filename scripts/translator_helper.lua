-- Translator helper for VN Combo - DST Compatible
local M = {}

function M.init(selectedLanguage, devMode, _G)
    -- Simple chat translation hook for DST
    -- Vì chúng ta đã có .po file được load, translator chủ yếu là để hook chat
    
    local function translateMessage(msg)
        -- Đơn giản trả về message gốc vì STRINGS đã được dịch bởi .po file
        return msg
    end

    -- Hook vào chat system để có thể translate messages nếu cần
    -- Hiện tại chỉ pass-through vì việc dịch chính đã được .po file xử lý
    if _G.Networking_Talk then
        local oldTalk = _G.Networking_Talk
        _G.Networking_Talk = function(guid, msg, ...)
            if msg and type(msg) == "string" then
                -- Có thể thêm logic translate custom messages ở đây nếu cần
                oldTalk(guid, translateMessage(msg), ...)
            else
                oldTalk(guid, msg, ...)
            end
        end
    end
    
    -- Export translate function
    M.translate = translateMessage
    
    print("[VN Combo] Translator initialized successfully")
end

return M
