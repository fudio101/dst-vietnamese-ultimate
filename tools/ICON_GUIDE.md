# DST Mod Icon Creation Guide

Complete guide for creating custom icons for Don't Starve Together mods using Klei's official tools.

## Quick Start

1. **Create Icon**: `python tools/create_icon.py`
2. **Convert to DST**: `python tools/convert_icon.py icons/mod_icon.png`
3. **Test in game!**

## Tools Overview

### 🎨 `create_icon.py`
**Purpose**: Generate beautiful PNG icons for DST mods
- Creates flag-style icons with customizable colors
- Professional typography with shadows
- Star elements (optional)
- Output: `icons/mod_icon.png`

### 🔄 `convert_icon.py` 
**Purpose**: Convert PNG to DST format using Klei's TextureConverter
- Uses official Klei TextureConverter.exe
- Creates DXT5 format with proper mipmaps
- 100% compatibility guaranteed
- Output: `modicon.tex` + `modicon.xml`

## Requirements

### Don't Starve Mod Tools
**Must install from Steam:**
1. Steam → Library → Tools
2. Find "Don't Starve Mod Tools" 
3. Install

Tool will be located at:
`../../../Don't Starve Mod Tools/mod_tools/tools/bin/TextureConverter.exe`

## Creating Custom Icons

### Method 1: Using Our Creator (Recommended)
```bash
python tools/create_icon.py
python tools/convert_icon.py icons/mod_icon.png
```

**Features**:
- ✅ Perfect 256x256 size
- ✅ Professional typography 
- ✅ Beautiful shadows and effects
- ✅ Vietnam flag preset included
- ✅ Official Klei conversion

### Method 2: Custom PNG
1. Create 256x256 PNG image
2. Use our converter: `python tools/convert_icon.py your_image.png`

## Icon Requirements

### Technical Specs
- **Size**: 256x256 pixels
- **Format**: PNG input → DXT5 .tex output
- **Files**: `modicon.tex` + `modicon.xml`
- **Location**: Mod root directory

### Design Guidelines
- **Clear at small sizes** (64x64 display)
- **High contrast** against dark backgrounds
- **Simple design** - avoid tiny details
- **Mod-relevant** imagery or text

## Customization

### Editing Colors
In `create_icon.py`, modify the `create_vietnam_icon()` function:

```python
def create_custom_icon():
    colors = {
        'background': (218, 2, 14, 255),  # Background color
        'border': (255, 215, 0, 255),     # Border color  
        'top_text': (255, 215, 0, 255),   # Top text color
        'bottom_text': (255, 255, 255, 255)  # Bottom text color
    }
    star_color = (255, 215, 0, 255)  # Star color (None to disable)
    
    return create_flag_icon(colors, star_color, "TOP", "BOTTOM")
```

### Text Options
- **Top text**: Usually "DST" or mod abbreviation
- **Bottom text**: Country name, mod name, or theme
- **Fonts**: Arial/Arial Black with fallbacks
- **Sizes**: Top 32px, Bottom 24px

## File Structure

```
your_mod/
├── modicon.tex          # DST texture file (DXT5)
├── modicon.xml          # DST atlas file  
├── icons/               # Source PNG files
│   └── mod_icon.png
├── tools/
│   ├── create_icon.py   # Icon creator
│   ├── convert_icon.py  # Klei converter
│   └── ICON_GUIDE.md    # This guide
└── convert_klei.bat     # Quick convert script
```

## Troubleshooting

### TextureConverter Not Found
- ✅ Install "Don't Starve Mod Tools" from Steam
- ✅ Check path: `../../../Don't Starve Mod Tools/mod_tools/tools/bin/`
- ✅ Restart terminal after installation

### Icon Not Showing
- ✅ Check files exist: `modicon.tex` + `modicon.xml`
- ✅ Restart DST completely
- ✅ Check Steam Workshop sync

### Conversion Errors
- ✅ Source PNG must be exactly 256x256
- ✅ Check PNG file is valid
- ✅ Try creating icon with our tool first

## Examples

### Vietnam Flag (Default)
```bash
python tools/create_icon.py
python tools/convert_icon.py icons/mod_icon.png
# Creates red background, gold star, "DST" + "VIỆT NAM"
```

### Quick Convert (Batch File)
```bash
./convert_klei.bat
# Runs create + convert automatically
```

## Technical Details

### Klei TextureConverter Parameters
- **Format**: DXT5 (compressed, high quality)
- **Platform**: OpenGL (DST compatible)  
- **Mipmaps**: Generated automatically
- **Size**: ~80-100KB typical

### File Formats
- **Input**: PNG 256x256 RGBA
- **Output**: .tex (DXT5 texture) + .xml (atlas)
- **Compatibility**: 100% DST native format

## Tips

1. **Use official tools**: Always use Klei's TextureConverter
2. **Test early**: Convert and test icons frequently
3. **Keep sources**: Save source PNG files  
4. **Simple design**: Less is more for small icons
5. **High contrast**: Ensure readability

## 🎨 Design Tips

### **Ý tưởng cho mod Việt hoá:**

#### **Theme 1: Vietnam Flag**
```
🇻🇳 Nền đỏ với ngôi sao vàng
📝 Thêm elements DST (cây, nhân vật)
🔤 Text "VN" hoặc "VI"
```

#### **Theme 2: Vietnamese Culture**
```
🏛️ Chùa một cột, đình làng
🌾 Cây lúa, lá cờ
🎭 Mặt nạ truyền thống
```

#### **Theme 3: DST + Vietnam**
```
🌳 Skill tree với màu cờ VN
⚙️ Game icons với dấu sắc
🔧 Wilson với nón lá
```

### **Color Palette:**
- **Red**: #DA020E (đỏ cờ VN)
- **Yellow**: #FFFF00 (vàng ngôi sao)  
- **Orange**: #FF8C00 (DST theme)
- **Brown**: #8B4513 (wood theme)

## 🖼️ Templates & Resources

### **Free Icon Resources:**
- **Flaticon**: flaticon.com (basic icons)
- **IconFinder**: iconfinder.com (premium)
- **DST Assets**: game files for reference

### **Fonts cho text:**
- **Roboto** (clean, modern)
- **Bangers** (cartoon style like DST)
- **VNI fonts** (Vietnamese)

## ⚡ Quick Templates

### **Template 1: Simple VN Flag**
```
1. Tạo background đỏ #DA020E
2. Thêm ngôi sao vàng ở center
3. Add text "DST" ở corner
4. Export 256x256 PNG
```

### **Template 2: Skill Tree Style**
```
1. Nền dark brown #3D2914
2. Tree branches pattern
3. Vietnamese text elements
4. Golden highlights
```

### **Template 3: Character Focus**
```
1. Wilson/Willow character
2. Vietnamese hat (nón lá)
3. VN flag background
4. Skill icons overlay
```

## 🚀 Deployment

### **Test icon:**
1. Copy `modicon.tex` và `modicon.xml` vào mod folder
2. Restart DST
3. Check trong Mods menu
4. Icon sẽ hiển thị 64x64

### **Steam Workshop:**
- Icon hiển thị 256x256 full resolution
- Cần upload cùng mod lần đầu
- Có thể update riêng icon sau

## 🛠️ Troubleshooting

### **Icon không hiển thị:**
- Kiểm tra file size = 256x256
- Đảm bảo có cả .tex và .xml
- Restart game
- Check console logs

### **Icon bị mờ/xấu:**
- Dùng ảnh gốc chất lượng cao
- Avoid quá nhiều detail nhỏ
- Test ở size 64x64 trước

### **Lỗi format:**
- Chỉ dùng PNG/TGA input
- Đảm bảo có alpha channel
- Check encoding UTF-8 cho XML

## 📝 Checklist

```
☐ Icon design 256x256 pixels
☐ Save as PNG với transparency
☐ Convert thành modicon.tex
☐ Tạo modicon.xml
☐ Test trong game
☐ Backup old icon files
☐ Update mod version
☐ Commit to git
```

## 🎉 Final Tips

- **Keep it simple**: Icon nhỏ nên tránh detail phức tạp
- **High contrast**: Đảm bảo nhìn rõ trên mọi background  
- **Consistent style**: Match với theme DST
- **Test multiple sizes**: 64x64, 128x128, 256x256
- **Version control**: Git commit icon changes riêng 