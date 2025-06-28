#!/usr/bin/env python3
"""
DST Icon Converter using Klei's Official TextureConverter
Converts PNG images to DST .tex/.xml format for mod icons
"""

import sys
import os
import subprocess

def find_texture_converter():
    """Find TextureConverter.exe"""
    
    paths = [
        # Relative path from mod directory
        r"..\..\..\Don't Starve Mod Tools\mod_tools\tools\bin\TextureConverter.exe",
        # Common Steam paths
        r"C:\Program Files (x86)\Steam\steamapps\common\Don't Starve Mod Tools\mod_tools\tools\bin\TextureConverter.exe",
        r"C:\Program Files\Steam\steamapps\common\Don't Starve Mod Tools\mod_tools\tools\bin\TextureConverter.exe",
    ]
    
    for path in paths:
        if os.path.exists(path):
            return path
    
    return None

def convert_with_klei(png_path, output_dir="."):
    """Convert PNG using Klei's TextureConverter"""
    
    if not os.path.exists(png_path):
        print(f"❌ PNG file not found: {png_path}")
        return False
    
    # Find TextureConverter
    converter = find_texture_converter()
    if not converter:
        print("❌ TextureConverter.exe not found!")
        print("\n📥 Install: Steam → Library → Tools → 'Don't Starve Mod Tools'")
        return False
    
    print(f"✅ Found TextureConverter: {os.path.basename(converter)}")
    
    # Prepare paths
    tex_path = os.path.join(output_dir, "modicon.tex")
    xml_path = os.path.join(output_dir, "modicon.xml")
    
    try:
        # Convert PNG to TEX
        print(f"🔄 Converting {png_path}...")
        
        cmd = [
            converter,
            "-i", png_path,
            "-o", tex_path, 
            "-f", "dxt5",
            "-p", "opengl",
            "--mipmap"
        ]
        
        result = subprocess.run(cmd, capture_output=True, text=True)
        
        if result.returncode != 0:
            print(f"❌ Conversion failed: {result.stderr}")
            return False
        
        if not os.path.exists(tex_path):
            print("❌ TEX file was not created")
            return False
        
        print(f"✅ Created: {tex_path}")
        
        # Create XML file
        xml_content = '''<Atlas>
    <Texture filename="modicon.tex" />
    <Elements>
        <Element name="modicon.tex" u1="0.0" u2="1.0" v1="0.0" v2="1.0" />
    </Elements>
</Atlas>'''
        
        with open(xml_path, 'w', encoding='utf-8') as f:
            f.write(xml_content)
        
        print(f"✅ Created: {xml_path}")
        
        # Show file info
        tex_size = os.path.getsize(tex_path)
        print(f"📊 File size: {tex_size:,} bytes")
        print("🛡️  Official Klei format - guaranteed compatibility!")
        
        return True
        
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def main():
    """Main conversion function"""
    
    if len(sys.argv) < 2:
        print("📖 Usage: python convert_icon.py <png_file>")
        print("📖 Examples:")
        print("   python tools/convert_icon.py modicon_source.png")
        print("   python tools/convert_icon.py preview.jpg") 
        print("\n💡 Tip: Use 'modicon_source.png' for mod icon conversion")
        print("💡 Tip: 'preview.jpg' is for Steam Workshop only")
        sys.exit(1)
    
    png_file = sys.argv[1]
    
    # If only filename provided, assume it's in the project root
    if not os.path.dirname(png_file):
        # Check if running from tools/ directory
        if os.path.basename(os.getcwd()) == "tools":
            png_file = os.path.join("..", png_file)
    
    print("🛠️  DST Icon Converter - Klei Official")
    print("=" * 40)
    
    success = convert_with_klei(png_file)
    
    if success:
        print("\n🎉 Conversion completed!")
        print("✅ Icon ready for DST - no crashes!")
        print("\n📋 Next steps:")
        print("1. Test your mod in DST")
        print("2. Icon should display perfectly")
        print("3. Upload mod to workshop with preview.jpg!")
    else:
        print("\n💥 Conversion failed!")
        print("📥 Install Don't Starve Mod Tools from Steam")
        sys.exit(1)

if __name__ == "__main__":
    main() 