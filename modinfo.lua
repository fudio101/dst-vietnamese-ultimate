name                    = "DST Việt hoá Ultimate"
description             = [[=== VIỆT HOÁ TOÀN DIỆN CHO DON'T STARVE TOGETHER ===

>> TÍNH NĂNG CHÍNH:
• Việt hoá 100% giao diện, hội thoại và mô tả item
• Font tiếng Việt được thiết kế riêng, hiển thị đẹp và rõ nét
• Việt hoá đầy đủ Cây Kỹ Năng cho tất cả nhân vật
• Hỗ trợ tùy chỉnh hiển thị chi tiết râu Wilson

>> HIỆU SUẤT:
• Mod nhẹ, tối ưu hiệu năng
• Không ảnh hưởng gameplay
• Tương thích với tất cả mod khác

>> ĐÓNG GÓP:
• Báo lỗi, đề xuất tính năng: GitHub Issues
• Cải thiện bản dịch: Fork → Edit → Pull Request
• Source code: github.com/fudio101/dst-vietnamese-ultimate
• Cộng đồng Việt Nam luôn chào đón mọi đóng góp!]]
author                  = "fudio101"
version                 = "1.1.2"
forumthread             = "https://github.com/fudio101/dst-vietnamese-ultimate"

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
