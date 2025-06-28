#!/usr/bin/env python3
"""
DST Mod Icon Creator
Create beautiful icons for Don't Starve Together mods
"""

from PIL import Image, ImageDraw, ImageFont
import os
import math

def create_flag_icon(country_colors, star_color, top_text, bottom_text):
    """Create a flag-style icon with customizable colors and text"""
    
    # Create 256x256 image  
    bg_color = country_colors['background']
    img = Image.new('RGBA', (256, 256), bg_color)
    draw = ImageDraw.Draw(img)
    
    # Simple clean background with subtle gradient
    center_x, center_y = 128, 128
    for y in range(256):
        # Simple vertical gradient for depth
        factor = 1 - abs(y - 128) / 256 * 0.15
        red = int(bg_color[0] * factor)
        red = max(int(bg_color[0] * 0.85), min(255, red))
        draw.line([(0, y), (256, y)], fill=(red, bg_color[1], bg_color[2], 255))
    
    # Single clean border
    border_color = country_colors['border']
    draw.rectangle([0, 0, 255, 255], outline=border_color, width=4)
    
    # Draw star (if enabled)
    if star_color:
        star_center = (128, 128)
        star_size = 55
        
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
        draw.polygon(star_points, outline=star_color, width=2)
    
    # Beautiful typography
    try:
        # Try different fonts for better appearance
        top_font = ImageFont.truetype("arial.ttf", 32)
        bottom_font = ImageFont.truetype("arial.ttf", 24)
    except:
        try:
            # Fallback to system fonts
            top_font = ImageFont.truetype("C:/Windows/Fonts/ariblk.ttf", 32)
            bottom_font = ImageFont.truetype("C:/Windows/Fonts/arial.ttf", 24)
        except:
            top_font = ImageFont.load_default()
            bottom_font = ImageFont.load_default()
    
    # Top text
    if top_text:
        try:
            top_bbox = draw.textbbox((0, 0), top_text, font=top_font)
            top_width = top_bbox[2] - top_bbox[0]
        except:
            top_width = len(top_text) * 16
        top_x = (256 - top_width) // 2
        top_y = 15
        
        # Strong shadow for top text
        draw.text((top_x + 3, top_y + 3), top_text, fill=(0, 0, 0, 150), font=top_font)
        draw.text((top_x + 1, top_y + 1), top_text, fill=(139, 69, 19, 100), font=top_font)
        draw.text((top_x, top_y), top_text, fill=country_colors['top_text'], font=top_font)
    
    # Bottom text
    if bottom_text:
        try:
            bottom_bbox = draw.textbbox((0, 0), bottom_text, font=bottom_font)
            bottom_width = bottom_bbox[2] - bottom_bbox[0]
        except:
            bottom_width = len(bottom_text) * 12
        bottom_x = (256 - bottom_width) // 2
        bottom_y = 215
        
        # Elegant shadow for bottom text
        draw.text((bottom_x + 2, bottom_y + 2), bottom_text, fill=(0, 0, 0, 120), font=bottom_font)
        draw.text((bottom_x + 1, bottom_y + 1), bottom_text, fill=(139, 69, 19, 80), font=bottom_font)
        draw.text((bottom_x, bottom_y), bottom_text, fill=country_colors['bottom_text'], font=bottom_font)
    
    return img

def create_vietnam_icon():
    """Create Vietnam flag icon preset"""
    colors = {
        'background': (218, 2, 14, 255),  # VN red
        'border': (255, 215, 0, 255),     # Gold
        'top_text': (255, 215, 0, 255),   # Gold for DST
        'bottom_text': (255, 255, 255, 255)  # White for country name
    }
    star_color = (255, 215, 0, 255)  # Gold star
    
    return create_flag_icon(colors, star_color, "DST", "VIỆT NAM")

def main():
    """Generate icon templates"""
    
    print("🎨 DST Mod Icon Creator")
    print("=" * 30)
    
    # Create output directory
    output_dir = "icons"
    os.makedirs(output_dir, exist_ok=True)
    
    # Generate Vietnam flag icon (default)
    print("🇻🇳 Creating Vietnam flag icon...")
    img = create_vietnam_icon()
    
    filepath = os.path.join(output_dir, "mod_icon.png")
    img.save(filepath)
    print(f"✅ Created: {filepath}")
    print(f"📏 Size: {img.size}")
    
    print("\n🌟 ICON FEATURES:")
    print("• ✨ Clean gradient background")
    print("• 🔥 Professional border")  
    print("• ⭐ Perfect star with uniform color")
    print("• 📝 Beautiful typography with shadows")
    print("• 🎨 Customizable colors and text")
    print("• 🚀 Professional DST mod appearance")
    
    print("\n📋 Next steps:")
    print("1. Preview icon:")
    print(f"   📁 Open: {filepath}")
    print("2. Convert to DST format:")
    print(f"   🔄 python tools/convert_icon.py {filepath}")
    print("3. Test in game!")
    
    return filepath

if __name__ == "__main__":
    main() 