import os
from PIL import Image, ImageDraw, ImageFont
import math

def create_fitness_logo(size):
    """Create a modern fitness logo with the specified size"""
    # Create image with transparent background
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Calculate dimensions based on size
    center = size // 2
    radius = int(size * 0.47)  # 47% of size for main circle
    
    # Create gradient background circle
    # We'll simulate gradient with multiple circles
    for i in range(radius, 0, -2):
        # Calculate color for gradient (orange to red)
        ratio = (radius - i) / radius
        r = int(255 * (0.42 + 0.28 * ratio))  # From #FF6B35 to #FF4757
        g = int(255 * (0.42 - 0.15 * ratio))  # Gradient calculation
        b = int(255 * (0.21 + 0.13 * ratio))
        alpha = int(255 * (0.95 - 0.1 * ratio))
        
        draw.ellipse([center-i, center-i, center+i, center+i], 
                    fill=(r, g, b, alpha))
    
    # Draw dumbbell
    dumbbell_scale = size / 1024  # Scale factor based on 1024px reference
    
    # Dumbbell dimensions
    weight_width = int(80 * dumbbell_scale)
    weight_height = int(120 * dumbbell_scale)
    bar_width = int(200 * dumbbell_scale)
    bar_height = int(30 * dumbbell_scale)
    
    # Left weight
    left_weight_x = center - int(180 * dumbbell_scale)
    left_weight_y = center - weight_height // 2
    draw.rounded_rectangle([left_weight_x, left_weight_y, 
                           left_weight_x + weight_width, left_weight_y + weight_height],
                          radius=int(15 * dumbbell_scale), fill=(255, 255, 255, 230))
    
    # Right weight
    right_weight_x = center + int(100 * dumbbell_scale)
    right_weight_y = center - weight_height // 2
    draw.rounded_rectangle([right_weight_x, right_weight_y,
                           right_weight_x + weight_width, right_weight_y + weight_height],
                          radius=int(15 * dumbbell_scale), fill=(255, 255, 255, 230))
    
    # Center bar
    bar_x = center - bar_width // 2
    bar_y = center - bar_height // 2
    draw.rounded_rectangle([bar_x, bar_y, bar_x + bar_width, bar_y + bar_height],
                          radius=int(15 * dumbbell_scale), fill=(255, 255, 255, 230))
    
    # Add grip lines on the bar
    grip_spacing = int(20 * dumbbell_scale)
    grip_start = center - int(60 * dumbbell_scale)
    for i in range(7):
        x = grip_start + i * grip_spacing
        draw.line([x, center - int(8 * dumbbell_scale), x, center + int(8 * dumbbell_scale)],
                 fill=(255, 255, 255, 180), width=max(1, int(2 * dumbbell_scale)))
    
    # Add "FX" text below dumbbell
    if size >= 64:  # Only add text for larger sizes
        try:
            # Try to use a bold font, fallback to default if not available
            font_size = max(int(size * 0.15), 12)
            font = ImageFont.load_default()
            
            text = "FX"
            # Get text bounding box
            bbox = draw.textbbox((0, 0), text, font=font)
            text_width = bbox[2] - bbox[0]
            text_height = bbox[3] - bbox[1]
            
            text_x = center - text_width // 2
            text_y = center + int(80 * dumbbell_scale)
            
            # Draw text with shadow
            draw.text((text_x + 2, text_y + 2), text, font=font, fill=(0, 0, 0, 100))
            draw.text((text_x, text_y), text, font=font, fill=(255, 255, 255, 255))
        except:
            pass  # Skip text if font loading fails
    
    # Add subtle heartbeat line at bottom for larger sizes
    if size >= 128:
        heartbeat_y = center + int(120 * dumbbell_scale)
        heartbeat_points = []
        start_x = center - int(100 * dumbbell_scale)
        
        # Create heartbeat pattern
        points = [0, 0, 20, 0, 25, -15, 30, 30, 35, -45, 40, 15, 45, 0, 
                 55, 0, 60, -15, 65, 30, 70, -45, 75, 15, 80, 0, 100, 0]
        
        for i in range(0, len(points), 2):
            x = start_x + int(points[i] * dumbbell_scale)
            y = heartbeat_y + int(points[i+1] * dumbbell_scale * 0.5)
            heartbeat_points.append((x, y))
        
        if len(heartbeat_points) > 1:
            for i in range(len(heartbeat_points) - 1):
                draw.line([heartbeat_points[i], heartbeat_points[i+1]], 
                         fill=(255, 255, 255, 200), width=max(1, int(3 * dumbbell_scale)))
    
    return img

def generate_android_icons():
    """Generate Android launcher icons"""
    android_sizes = {
        'mipmap-mdpi': 48,
        'mipmap-hdpi': 72,
        'mipmap-xhdpi': 96,
        'mipmap-xxhdpi': 144,
        'mipmap-xxxhdpi': 192
    }
    
    for folder, size in android_sizes.items():
        # Create directory if it doesn't exist
        dir_path = f'android/app/src/main/res/{folder}'
        os.makedirs(dir_path, exist_ok=True)
        
        # Generate and save icon
        logo = create_fitness_logo(size)
        logo.save(f'{dir_path}/ic_launcher.png', 'PNG')
        print(f'Generated Android icon: {dir_path}/ic_launcher.png ({size}x{size})')

def generate_ios_icons():
    """Generate iOS app icons"""
    ios_sizes = {
        'Icon-App-20x20@1x.png': 20,
        'Icon-App-20x20@2x.png': 40,
        'Icon-App-20x20@3x.png': 60,
        'Icon-App-29x29@1x.png': 29,
        'Icon-App-29x29@2x.png': 58,
        'Icon-App-29x29@3x.png': 87,
        'Icon-App-40x40@1x.png': 40,
        'Icon-App-40x40@2x.png': 80,
        'Icon-App-40x40@3x.png': 120,
        'Icon-App-60x60@2x.png': 120,
        'Icon-App-60x60@3x.png': 180,
        'Icon-App-76x76@1x.png': 76,
        'Icon-App-76x76@2x.png': 152,
        'Icon-App-83.5x83.5@2x.png': 167,
        'Icon-App-1024x1024@1x.png': 1024
    }
    
    dir_path = 'ios/Runner/Assets.xcassets/AppIcon.appiconset'
    
    for filename, size in ios_sizes.items():
        logo = create_fitness_logo(size)
        logo.save(f'{dir_path}/{filename}', 'PNG')
        print(f'Generated iOS icon: {filename} ({size}x{size})')

def generate_web_icons():
    """Generate web icons"""
    web_icons = {
        'favicon.png': 32,
        'icons/Icon-192.png': 192,
        'icons/Icon-512.png': 512,
        'icons/Icon-maskable-192.png': 192,
        'icons/Icon-maskable-512.png': 512
    }
    
    # Create icons directory
    os.makedirs('web/icons', exist_ok=True)
    
    for filename, size in web_icons.items():
        logo = create_fitness_logo(size)
        
        # For maskable icons, add safe zone padding
        if 'maskable' in filename:
            # Create larger canvas with padding for maskable icons
            padded_size = int(size * 1.2)
            padded_img = Image.new('RGBA', (padded_size, padded_size), (0, 0, 0, 0))
            
            # Paste logo in center
            offset = (padded_size - size) // 2
            padded_img.paste(logo, (offset, offset), logo)
            
            # Resize back to original size
            logo = padded_img.resize((size, size), Image.Resampling.LANCZOS)
        
        logo.save(f'web/{filename}', 'PNG')
        print(f'Generated web icon: {filename} ({size}x{size})')

def generate_windows_icon():
    """Generate Windows ICO file"""
    # ICO files can contain multiple sizes
    sizes = [16, 32, 48, 64, 128, 256]
    images = []
    
    for size in sizes:
        logo = create_fitness_logo(size)
        images.append(logo)
    
    # Save as ICO
    images[0].save('windows/runner/resources/app_icon.ico', 
                   format='ICO', sizes=[(img.width, img.height) for img in images])
    print(f'Generated Windows icon: app_icon.ico (multiple sizes)')

def main():
    """Generate all app icons"""
    print("Generating modern fitness logo for FitnestX...")
    print("=" * 50)
    
    try:
        generate_android_icons()
        print()
        generate_ios_icons()
        print()
        generate_web_icons()
        print()
        generate_windows_icon()
        print()
        print("✅ All icons generated successfully!")
        print("🎯 Modern fitness-themed logo created for all platforms")
        
    except Exception as e:
        print(f"❌ Error generating icons: {e}")
        return False
    
    return True

if __name__ == "__main__":
    main()
