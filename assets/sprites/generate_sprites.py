from PIL import Image, ImageDraw
import os

def create_building_sprites():
    output_dir = "/home/vane/.openclaw/workspace/projects/idle-block-game/assets/sprites/"
    
    sprites = {
        "miner": (0.55, 0.27, 0.07, "square"),      # 棕色正方形
        "factory": (0.5, 0.5, 0.5, "rectangle"),    # 灰色长方形
        "bank": (1.0, 0.84, 0.0, "triangle"),       # 金色三角形
        "lab": (0.0, 0.0, 1.0, "circle"),           # 蓝色圆形
        "space": (0.5, 0.0, 0.5, "hexagon"),        # 紫色六边形
        "coin": (1.0, 0.84, 0.0, "circle_small"),   # 金币
        "diamond": (0.0, 0.8, 1.0, "diamond"),      # 钻石
    }
    
    for name, (r, g, b, shape) in sprites.items():
        img = Image.new('RGBA', (64, 64), (0, 0, 0, 0))
        draw = ImageDraw.Draw(img)
        
        if shape == "square":
            draw.rectangle([8, 8, 56, 56], fill=(int(r*255), int(g*255), int(b*255), 255))
        elif shape == "rectangle":
            draw.rectangle([4, 16, 60, 48], fill=(int(r*255), int(g*255), int(b*255), 255))
        elif shape == "triangle":
            draw.polygon([(32, 8), (8, 56), (56, 56)], fill=(int(r*255), int(g*255), int(b*255), 255))
        elif shape == "circle":
            draw.ellipse([8, 8, 56, 56], fill=(int(r*255), int(g*255), int(b*255), 255))
        elif shape == "circle_small":
            draw.ellipse([16, 16, 48, 48], fill=(int(r*255), int(g*255), int(b*255), 255))
        elif shape == "hexagon":
            points = [(32, 8), (56, 20), (56, 44), (32, 56), (8, 44), (8, 20)]
            draw.polygon(points, fill=(int(r*255), int(g*255), int(b*255), 255))
        elif shape == "diamond":
            points = [(32, 8), (56, 32), (32, 56), (8, 32)]
            draw.polygon(points, fill=(int(r*255), int(g*255), int(b*255), 255))
        
        img.save(f"{output_dir}{name}.png")
        print(f"✓ 生成：{name}.png")
        
        # 创建 Godot .import 文件
        import_content = f"""[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://{name}"
path="res://assets/sprites/{name}.png"
metadata={{
"vram_texture": false
}}

[deps]

source_file="res://assets/sprites/{name}.png"
dest_files=["res://.godot/imported/{name}.png.ctex"]

[params]

compress/mode=0
compress/high_quality=false
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1
"""
        with open(f"{output_dir}{name}.png.import", "w") as f:
            f.write(import_content)
        print(f"✓ 生成：{name}.png.import")

if __name__ == "__main__":
    create_building_sprites()
    print("\n✅ 所有精灵生成完成！")
