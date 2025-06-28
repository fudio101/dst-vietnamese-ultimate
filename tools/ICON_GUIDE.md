# DST Mod Icon Creation Guide

Complete guide for creating custom icons for Don't Starve Together mods using Klei's official tools.

## Quick Start

1. **Create Icons**: `python tools/create_icon.py`
2. **Convert Mod Icon**: `python tools/convert_icon.py modicon_source.png`
3. **Upload to Workshop** using `preview.jpg`!

## Tools Overview

### 🎨 `create_icon.py`
**Purpose**: Generate beautiful icons for DST mods and Steam Workshop
- Creates **2 icons** automatically:
  - `preview.jpg` (512x512) - Steam Workshop preview image
  - `modicon_source.png` (256x256) - Source for mod icon conversion
- Professional typography with shadows
- Star elements and gradient backgrounds
- Vietnam flag preset included

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

## Creating Icons

### Method 1: Using Our Creator (Recommended)
```bash
# Step 1: Create both preview and mod icons
python tools/create_icon.py

# Step 2: Convert mod icon to DST format  
python tools/convert_icon.py modicon_source.png
```

**Output Files**:
- ✅ `preview.jpg` (512x512) - **Steam Workshop preview**
- ✅ `modicon_source.png` (256x256) - **Source for conversion**
- ✅ `modicon.tex` + `modicon.xml` - **DST mod icon**

### Method 2: Custom PNG
1. Create your own 256x256 PNG image
2. Place in mod root directory
3. Convert: `python tools/convert_icon.py your_image.png`

## Icon Types & Usage

### 🖼️ Workshop Preview (`preview.jpg`)
- **Size**: 512x512 pixels
- **Format**: JPEG (high quality)
- **Usage**: Steam Workshop preview image
- **Location**: Mod root directory
- **Purpose**: Attracts users browsing Workshop

### 🎮 Mod Icon (`modicon.tex` + `modicon.xml`)
- **Size**: 256x256 pixels (displayed as 64x64 in game)
- **Format**: DXT5 texture + atlas XML
- **Usage**: In-game mod selection menu
- **Location**: Mod root directory
- **Purpose**: Identifies mod in DST interface

### 🎯 Source Icon (`modicon_source.png`)
- **Size**: 256x256 pixels
- **Format**: PNG with transparency
- **Usage**: Source file for conversion to .tex
- **Location**: Mod root directory  
- **Purpose**: Backup and future edits

## Icon Requirements

### Workshop Preview Specs
- **Size**: 512x512 pixels
- **Format**: JPEG (RGB)
- **Quality**: High (95%)
- **Aspect ratio**: 1:1 (square)

### Mod Icon Specs
- **Size**: 256x256 pixels
- **Format**: PNG input → DXT5 .tex output
- **Files**: `modicon.tex` + `modicon.xml`
- **Location**: Mod root directory

### Design Guidelines
- **Clear at small sizes** (64x64 display in game)
- **High contrast** against dark backgrounds
- **Simple design** - avoid tiny details
- **Mod-relevant** imagery or text
- **Professional appearance** for Workshop browsing

## Customization

### Editing Colors
In `create_icon.py`, modify the `create_vietnam_icon()` function:

```python
def create_custom_icon(size=(256, 256)):
    colors = {
        'background': (218, 2, 14, 255),  # Background color
        'border': (255, 215, 0, 255),     # Border color  
        'top_text': (255, 215, 0, 255),   # Top text color
        'bottom_text': (255, 255, 255, 255)  # Bottom text color
    }
    star_color = (255, 215, 0, 255)  # Star color (None to disable)
    
    return create_flag_icon(colors, star_color, "TOP", "BOTTOM", size)
```

### Text Options
- **Top text**: Usually "DST" or mod abbreviation
- **Bottom text**: Country name, mod name, or theme
- **Fonts**: Arial/Arial Black with fallbacks
- **Auto-scaling**: Font sizes adjust based on image size

## File Structure

```
your_mod/
├── modicon.tex              # DST texture file (DXT5)
├── modicon.xml              # DST atlas file  
├── modicon_source.png       # Source PNG (256x256)
├── preview.jpg              # Workshop preview (512x512)
├── tools/
│   ├── create_icon.py       # Icon creator
│   ├── convert_icon.py      # Klei converter
│   └── ICON_GUIDE.md        # This guide
└── modinfo.lua              # Mod configuration
```

## Workshop Upload Workflow

### 1. Create Icons
```bash
python tools/create_icon.py
```
This creates both files you need:
- `preview.jpg` - for Workshop
- `modicon_source.png` - for game

### 2. Convert Mod Icon
```bash
python tools/convert_icon.py modicon_source.png
```
This creates `modicon.tex` + `modicon.xml`

### 3. Upload to Workshop
1. Open ModUploader in DST
2. Select your mod folder
3. Use `preview.jpg` as preview image
4. Upload - the mod icon will work automatically!

## Troubleshooting

### TextureConverter Not Found
- ✅ Install "Don't Starve Mod Tools" from Steam
- ✅ Check path: `../../../Don't Starve Mod Tools/mod_tools/tools/bin/`
- ✅ Restart terminal after installation

### Icon Not Showing in Game
- ✅ Check files exist: `modicon.tex` + `modicon.xml` in mod root
- ✅ Restart DST completely
- ✅ Verify files are in correct location (not in subfolders)

### Workshop Preview Issues
- ✅ Use `preview.jpg` (512x512)
- ✅ Check file size < 1MB
- ✅ JPEG format only for preview

### Conversion Errors
- ✅ Source PNG must be exactly 256x256
- ✅ Check PNG file is valid
- ✅ Try creating icon with our tool first
- ✅ Run script from mod root directory

## Examples

### Vietnam Flag (Default)
```bash
python tools/create_icon.py
python tools/convert_icon.py modicon_source.png
# Creates:
# - preview.jpg (512x512) with red background, gold star, "DST" + "VIỆT NAM"
# - modicon_source.png (256x256) same design
# - modicon.tex + modicon.xml (DST format)
```

### Custom Design
1. Edit colors in `create_icon.py`
2. Run `python tools/create_icon.py`
3. Convert: `python tools/convert_icon.py modicon_source.png`
4. Upload using `preview.jpg`

## Technical Details

### Klei TextureConverter Parameters
- **Format**: DXT5 (compressed, high quality)
- **Platform**: OpenGL (DST compatible)  
- **Mipmaps**: Generated automatically
- **Size**: ~80-100KB typical

### File Formats
- **Workshop Preview**: JPEG 512x512 RGB (~30-50KB)
- **Mod Icon Source**: PNG 256x256 RGBA (~8-15KB)
- **DST Icon**: .tex (DXT5 texture) + .xml (atlas) (~85KB)

## Design Tips

### **Vietnam Mod Themes:**

#### **Theme 1: Vietnam Flag**
```
🇻🇳 Red background with golden star
📝 Add DST elements (trees, characters)
🔤 Text "VN", "VI", or "DST"
```

#### **Theme 2: Vietnamese Culture**
```
🏛️ Traditional architecture
🌾 Rice plants, cultural symbols
🎭 Traditional masks
```

#### **Theme 3: DST + Vietnam**
```
🌳 Skill tree with VN flag colors
⚙️ Game icons with Vietnamese accents
🔧 Wilson with conical hat (nón lá)
```

### **Color Palette:**
- **Red**: #DA020E (Vietnam flag red)
- **Yellow**: #FFD700 (Golden star)  
- **Orange**: #FF8C00 (DST theme)
- **Brown**: #8B4513 (Wood theme)

## Best Practices

### **For Workshop Success:**
1. **Eye-catching preview**: Use `preview.jpg` (512x512)
2. **Clear branding**: Include mod name or theme
3. **High contrast**: Readable thumbnails
4. **Consistent style**: Match your mod's theme

### **For Game Integration:**
1. **Simple design**: Clear at 64x64 display size
2. **Recognizable**: Easy to identify in mod list
3. **Appropriate theme**: Match mod functionality

## Quick Checklist

```
☐ Run python tools/create_icon.py
☐ Check preview.jpg (512x512) looks good
☐ Run python tools/convert_icon.py modicon_source.png
☐ Test modicon.tex shows in game
☐ Backup all source files
☐ Ready for Workshop upload!
```

## Final Tips

- **Always create both icons**: Workshop preview + in-game icon
- **Test at small sizes**: Preview how icon looks at 64x64
- **Keep source files**: Save `modicon_source.png` for future edits
- **Version control**: Commit icon changes to git
- **Quality over detail**: Simple, clear designs work best
- **Workshop first impression**: Use high-quality `preview.jpg` 