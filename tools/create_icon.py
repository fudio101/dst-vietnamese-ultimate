#!/usr/bin/env python3
"""
DST Mod Icon Creator
Create beautiful icons for Don't Starve Together mods
- Workshop preview image (640x360)
- Mod icon source (256x256) 
"""

from PIL import Image, ImageDraw, ImageFont
import os
import math

def create_flag_icon(country_colors, star_color, top_text, bottom_text, size=(256, 256)):
    """Create a flag-style icon with customizable colors and text"""
    
    # Create image with specified size
    bg_color = country_colors['background']
    img = Image.new('RGBA', size, bg_color)
    draw = ImageDraw.Draw(img)
    
    # Simple clean background with subtle gradient
    center_x, center_y = size[0] // 2, size[1] // 2
    for y in range(size[1]):
        # Simple vertical gradient for depth
        factor = 1 - abs(y - center_y) / size[1] * 0.15
        red = int(bg_color[0] * factor)
        red = max(int(bg_color[0] * 0.85), min(255, red))
        draw.line([(0, y), (size[0], y)], fill=(red, bg_color[1], bg_color[2], 255))
    
    # Single clean border
    border_color = country_colors['border']
    border_width = max(2, size[0] // 128)  # Scale border with size
    draw.rectangle([0, 0, size[0]-1, size[1]-1], outline=border_color, width=border_width)
    
    # Draw star (if enabled)
    if star_color:
        star_center = (center_x, center_y)
        star_size = min(size[0], size[1]) // 5  # Scale star with image size
        
        # Create perfect 5-pointed star
        outer_points = []
        inner_points = []
        for i in range(5):
            # Outer points
            angle = -math.pi/2 + i * 2 * math.pi / 5
            x = star_center[0] + star_size * math.cos(angle)
            y = star_center[1] + star_size * math.sin(angle)
            outer_points.append((x, y))
            
            # Inner points
            angle += math.pi / 5
            x = star_center[0] + star_size * 0.38 * math.cos(angle)
            y = star_center[1] + star_size * 0.38 * math.sin(angle)
            inner_points.append((x, y))
        
        # Combine for perfect star shape
        star_points = []
        for i in range(5):
            star_points.append(outer_points[i])
            star_points.append(inner_points[i])
        
        # Clean star with uniform color
        draw.polygon(star_points, fill=star_color)
        draw.polygon(star_points, outline=star_color, width=max(1, border_width//2))
    
    # Beautiful typography - scale font with image size
    base_size = min(size[0], size[1])
    top_font_size = max(16, base_size // 8)
    bottom_font_size = max(12, base_size // 11)
    
    try:
        # Try different fonts for better appearance
        top_font = ImageFont.truetype("arial.ttf", top_font_size)
        bottom_font = ImageFont.truetype("arial.ttf", bottom_font_size)
    except:
        try:
            # Fallback to system fonts
            top_font = ImageFont.truetype("C:/Windows/Fonts/ariblk.ttf", top_font_size)
            bottom_font = ImageFont.truetype("C:/Windows/Fonts/arial.ttf", bottom_font_size)
        except:
            top_font = ImageFont.load_default()
            bottom_font = ImageFont.load_default()
    
    # Top text
    if top_text:
        try:
            top_bbox = draw.textbbox((0, 0), top_text, font=top_font)
            top_width = top_bbox[2] - top_bbox[0]
        except:
            top_width = len(top_text) * (top_font_size // 2)
        top_x = (size[0] - top_width) // 2
        top_y = size[1] // 16  # Scale position with image size
        
        # Strong shadow for top text
        shadow_offset = max(1, size[0] // 128)
        draw.text((top_x + shadow_offset*2, top_y + shadow_offset*2), top_text, fill=(0, 0, 0, 150), font=top_font)
        draw.text((top_x + shadow_offset, top_y + shadow_offset), top_text, fill=(139, 69, 19, 100), font=top_font)
        draw.text((top_x, top_y), top_text, fill=country_colors['top_text'], font=top_font)
    
    # Bottom text
    if bottom_text:
        try:
            bottom_bbox = draw.textbbox((0, 0), bottom_text, font=bottom_font)
            bottom_width = bottom_bbox[2] - bottom_bbox[0]
        except:
            bottom_width = len(bottom_text) * (bottom_font_size // 2)
        bottom_x = (size[0] - bottom_width) // 2
        bottom_y = size[1] - size[1] // 8  # Scale position with image size
        
        # Elegant shadow for bottom text
        shadow_offset = max(1, size[0] // 128)
        draw.text((bottom_x + shadow_offset, bottom_y + shadow_offset), bottom_text, fill=(0, 0, 0, 120), font=bottom_font)
        draw.text((bottom_x + shadow_offset//2, bottom_y + shadow_offset//2), bottom_text, fill=(139, 69, 19, 80), font=bottom_font)
        draw.text((bottom_x, bottom_y), bottom_text, fill=country_colors['bottom_text'], font=bottom_font)
    
    return img

def create_vietnam_icon(size=(256, 256)):
    """Create Vietnam flag icon preset"""
    colors = {
        'background': (218, 2, 14, 255),  # VN red
        'border': (255, 215, 0, 255),     # Gold
        'top_text': (255, 215, 0, 255),   # Gold for DST
        'bottom_text': (255, 255, 255, 255)  # White for country name
    }
    star_color = (255, 215, 0, 255)  # Gold star
    
    return create_flag_icon(colors, star_color, "DST", "VIỆT NAM", size)

def main():
    """Generate icon templates"""
    
    print("🎨 DST Mod Icon Creator")
    print("=" * 30)
    
    # Generate Vietnam flag icons
    print("🇻🇳 Creating Vietnam flag icons...")
    
    # 1. Workshop Preview Image (512x512 - Steam Workshop standard)
    print("📸 Creating workshop preview image...")
    preview_img = create_vietnam_icon(size=(512, 512))
    preview_path = "preview.jpg"
    # Convert RGBA to RGB for JPEG
    if preview_img.mode == 'RGBA':
        preview_img = preview_img.convert('RGB')
    preview_img.save(preview_path, "JPEG", quality=95)
    print(f"✅ Created: {preview_path} (512x512 - Workshop preview)")
    
    # 2. Mod Icon Source (256x256 - for conversion to .tex)
    print("🎯 Creating mod icon source...")
    icon_img = create_vietnam_icon(size=(256, 256))
    icon_path = "modicon_source.png"
    icon_img.save(icon_path, "PNG")
    print(f"✅ Created: {icon_path} (256x256 - For .tex conversion)")
    
    print("\n🌟 ICON FEATURES:")
    print("• ✨ Clean gradient background")
    print("• 🔥 Professional border")  
    print("• ⭐ Perfect star with uniform color")
    print("• 📝 Beautiful typography with shadows")
    print("• 🎨 Customizable colors and text")
    print("• 🚀 Professional DST mod appearance")
    print("• 📏 Multiple sizes for different purposes")
    
    print("\n📋 Next steps:")
    print("1. Preview workshop image:")
    print(f"   📁 Open: {preview_path}")
    print("2. Convert mod icon to DST format:")
    print(f"   🔄 python tools/convert_icon.py {icon_path}")
    print("3. Upload to workshop using preview.jpg!")
    
    return icon_path, preview_path

if __name__ == "__main__":
    main() 