name = "[VN] Combo Việt hoá + Announcer + SkillTree"
-- Mô tả gộp: bản dịch tiếng Việt, thông báo trạng thái và Việt hoá Cây Kỹ Năng.
description = [[Bao gồm:
• Việt hoá toàn bộ giao diện và hội thoại (sử dụng vietnamese.po)
• Thông báo trạng thái (máu/đói/tinh thần, v.v.) bằng tiếng Việt hoặc tiếng Anh
• Việt hoá Cây Kỹ Năng cho các nhân vật (Wilson, Willow, Wendy, Wortox, Wigfrid, Wolfgang, Woodie, Wormwood, Winona …)

Chỉ cần bật duy nhất mod này, tắt hai mod cũ.]]
author      = "Shinosan & nqtonj (merged by AI)"
version     = "1.0.0"

priority = 1000000

icon = "modicon.tex"
icon_atlas = "modicon.xml"

api_version_dst = 10

-- Tương thích
client_only_mod      = true
server_only_mod      = false
all_clients_require_mod = false
dst_compatible       = true

-- Tag tìm kiếm
server_filter_tags   = {"VN", "Vietnamese", "Status", "SkillTree"}

--------------------------------------------------------------------
-- Cấu hình ---------------------------------------------------------
--------------------------------------------------------------------
configuration_options = {
    {
        name  = "THONG_BAO_TRANG_THAI",
        label = "Thông báo trạng thái",
        hover = "Bật/Tắt thông báo trạng thái",
        options = {{description = "On", data = "On"},{description="Off", data="Off"}},
        default = "On",
    },
    {
        name = "LANGUAGE",
        label = "Ngôn ngữ",
        hover = "Chọn ngôn ngữ cho thông báo trạng thái",
        options = {{description="Tự phát hiện",data="detect"},{description="English",data="english"},{description="Tiếng Việt",data="vietnam"}},
        default = "vietnam",
    },
    {name="WHISPER",label="Whisper by default",options={{description="Có",data=true},{description="Không",data=false}},default=false},
    {name="EXPLICIT",label="Show current/max",options={{description="Có",data=true},{description="Không",data=false}},default=true},
    {name="SHOWPROTOTYPER",label="Announce Prototyper",options={{description="Có",data=true},{description="Không",data=false}},default=true},
    {name="SHOWEMOJI",label="Announce Emoji",options={{description="Có",data=true},{description="Không",data=false}},default=true},
    {name="SHOWDURABILITY",label="Announce Durability",options={{description="Có",data=true},{description="Không",data=false}},default=true},
    {
        name="BEARD_INSULATION",label="Beard Insulation",hover="Mức chi tiết khi hiển thị nâng cấp cách nhiệt của râu Wilson",
        options={{description="% Only",data="PERCENT_ONLY"},{description="% + Magnificent",data="MAGNIFICENT"},{description="% + 3 Beard Stage",data="SUPER_DETAILED"}},
        default="MAGNIFICENT",
    },
    {
        name="BEARD_SPEED",label="Beard Speed",hover="Hiển thị tốc độ mọc râu mặc định hay không",
        options={{description="Không hiển thị",data="no_default"},{description="Một phần",data="some_default"},{description="Tất cả",data="all_default"}},
        default="no_default",
    },
    {name="WIG_BEEF_SONG",label="Wigfrid Beefalo Song",hover="Bật/Tắt bài hát khi Wigfrid cưỡi Beefalo (skill Noble Mount III)",options={{description="Enabled",data="Enabled"},{description="Disabled",data="Disabled"}},default="Enabled"},
} 