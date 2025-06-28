name                    = "[DST] Việt hoá Ultimate"
-- Mô tả gộp: bản dịch tiếng Việt và Việt hoá Cây Kỹ Năng.
description             = [[Bao gồm:
• Việt hoá toàn bộ giao diện và hội thoại (sử dụng vietnamese.po)
• Font tiếng Việt hiển thị đẹp và rõ ràng
• Việt hoá Cây Kỹ Năng cho các nhân vật (Wilson, Willow, Wendy, Wortox, Wigfrid, Wolfgang, Woodie, Wormwood, Winona ...)

Mod đơn giản, nhẹ và ổn định.]]
author                  = "fudio101"
version                 = "1.1.0"

priority                = 1000000

icon                    = "modicon.tex"
icon_atlas              = "modicon.xml"

api_version_dst         = 10

-- Tương thích
client_only_mod         = true
server_only_mod         = false
all_clients_require_mod = false
dst_compatible          = true

-- Tag tìm kiếm
server_filter_tags      = { "VN", "Vietnamese", "SkillTree", "Font" }

--------------------------------------------------------------------
-- Cấu hình ---------------------------------------------------------
--------------------------------------------------------------------
configuration_options   = {
    {
        name = "BEARD_INSULATION",
        label = "Beard Insulation",
        hover = "Mức chi tiết khi hiển thị nâng cấp cách nhiệt của râu Wilson",
        options = { { description = "% Only", data = "PERCENT_ONLY" }, { description = "% + Magnificent", data = "MAGNIFICENT" }, { description = "% + 3 Beard Stage", data = "SUPER_DETAILED" } },
        default = "MAGNIFICENT",
    },
    {
        name = "BEARD_SPEED",
        label = "Beard Speed",
        hover = "Hiển thị tốc độ mọc râu mặc định hay không",
        options = { { description = "Không hiển thị", data = "no_default" }, { description = "Một phần", data = "some_default" }, { description = "Tất cả", data = "all_default" } },
        default = "no_default",
    },
}
