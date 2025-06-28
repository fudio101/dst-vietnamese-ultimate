#!/usr/bin/env python3
"""
DST Vietnamese Ultimate - Build Publisher
Tạo bản publish sạch sẽ để upload lên Steam Workshop
"""

import os
import shutil
import sys
from pathlib import Path

# =============================================================================
# PUBLISH CONFIGURATION - Dễ dàng cập nhật danh sách files/folders
# =============================================================================

PUBLISH_CONFIG = {
    # Thư mục đích
    "publish_dir": "dst-vietnamese-ultimate-publish",
    
    # Files đơn lẻ cần copy (file_name: description)
    "files": {
        # Core mod files
        "modinfo.lua": "Mod configuration",
        "modmain.lua": "Main mod script", 
        "modicon.tex": "DST mod icon texture",
        "modicon.xml": "DST mod icon atlas",
        
        # Workshop assets
        "preview.jpg": "Steam Workshop preview image",
        
        # Translation files
        "vietnamese.po": "Translation source file",
        "vietnamese.mo": "Compiled translation file",
        
        # Documentation
        "README.md": "Mod documentation",
        "LICENSE": "License file",
    },
    
    # Thư mục cần copy toàn bộ (folder_name: description)
    "directories": {
        "fonts": "Vietnamese font packages",
        "scripts": "Custom mod scripts",
    },
    
    # Files/folders bỏ qua (không copy)
    "exclude": [
        ".git",
        ".vscode", 
        "tools",
        "modicon_source.png",
        ".gitignore",
        "build_publish.py",
        "__pycache__",
        "*.pyc",
        ".DS_Store",
    ]
}

def print_header():
    """In header đẹp cho script"""
    print("=" * 50)
    print("🇻🇳 DST Vietnamese Ultimate - Build Publisher")
    print("=" * 50)

def clean_publish_dir(publish_dir):
    """Xóa và tạo lại thư mục publish"""
    if publish_dir.exists():
        print(f"🧹 Cleaning old publish directory: {publish_dir}")
        shutil.rmtree(publish_dir)
    
    print(f"📁 Creating fresh publish directory: {publish_dir}")
    publish_dir.mkdir(parents=True, exist_ok=True)

def copy_files(config, publish_dir):
    """Copy các files đơn lẻ"""
    print("\n📋 Copying individual files...")
    
    copied_files = 0
    for file_name, description in config["files"].items():
        source_file = Path(file_name)
        
        if source_file.exists():
            dest_file = publish_dir / file_name
            shutil.copy2(source_file, dest_file)
            size = source_file.stat().st_size
            print(f"  ✅ {file_name} ({size:,} bytes) - {description}")
            copied_files += 1
        else:
            print(f"  ⚠️  {file_name} - File not found (skipped)")
    
    return copied_files

def copy_directories(config, publish_dir):
    """Copy các thư mục"""
    print("\n📁 Copying directories...")
    
    copied_dirs = 0
    for dir_name, description in config["directories"].items():
        source_dir = Path(dir_name)
        
        if source_dir.exists() and source_dir.is_dir():
            dest_dir = publish_dir / dir_name
            shutil.copytree(source_dir, dest_dir)
            
            # Đếm files trong thư mục
            file_count = len(list(dest_dir.rglob("*")))
            print(f"  ✅ {dir_name}/ ({file_count} items) - {description}")
            copied_dirs += 1
        else:
            print(f"  ⚠️  {dir_name}/ - Directory not found (skipped)")
    
    return copied_dirs

def calculate_publish_size(publish_dir):
    """Tính tổng dung lượng thư mục publish"""
    total_size = 0
    file_count = 0
    
    for file_path in publish_dir.rglob("*"):
        if file_path.is_file():
            total_size += file_path.stat().st_size
            file_count += 1
    
    return total_size, file_count

def print_summary(publish_dir, copied_files, copied_dirs):
    """In tóm tắt kết quả"""
    total_size, file_count = calculate_publish_size(publish_dir)
    size_mb = total_size / (1024 * 1024)
    
    print("\n" + "=" * 50)
    print("✅ Build completed successfully!")
    print("=" * 50)
    print(f"📂 Publish directory: {publish_dir.absolute()}")
    print(f"📊 Total files: {file_count:,}")
    print(f"📦 Total size: {size_mb:.2f} MB ({total_size:,} bytes)")
    print(f"📋 Copied files: {copied_files}")
    print(f"📁 Copied directories: {copied_dirs}")
    
    print("\n🚀 Ready for Workshop upload!")
    print("\n💡 Next steps:")
    print("   1. Open ModUploader in DST")
    print(f"   2. Browse to: {publish_dir.absolute()}")
    print("   3. Upload to Workshop!")
    print("\n" + "=" * 50)

def main():
    """Main function"""
    print_header()
    
    try:
        # Đường dẫn thư mục publish
        publish_dir = Path(PUBLISH_CONFIG["publish_dir"])
        
        # Clean và tạo thư mục publish
        clean_publish_dir(publish_dir)
        
        # Copy files và directories
        copied_files = copy_files(PUBLISH_CONFIG, publish_dir)
        copied_dirs = copy_directories(PUBLISH_CONFIG, publish_dir)
        
        # In tóm tắt
        print_summary(publish_dir, copied_files, copied_dirs)
        
    except Exception as e:
        print(f"\n❌ Error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main() 