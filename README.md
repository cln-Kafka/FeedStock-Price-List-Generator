# FeedStock

A mobile application designed for animal feed store owners to create and share professional price lists. The app allows store owners to input prices for their products across different package sizes (25kg, 50kg, ton), then dynamically generates high-quality promotional images that can be saved locally or shared on social media platforms like Facebook, WhatsApp, and Telegram.

## Screenshots

<div align="center">

| Home Screen | Price Input Screen | Image Preview Screen |
|-------------|----------------|---------------|
| ![Home Screen](READEME-assets/screenshots/home.png) | ![Price Input Screen](READEME-assets/screenshots/price_input.png) | ![Image Preview Screen](READEME-assets/screenshots/image_preview.png) |

</div>

## Features

- ✅ **Dynamic SVG Image Generation using flutter_svg** - Creates high-quality, scalable price list images
- ✅ **Interactive Image Viewer** - Preview and review generated images before sharing
- ✅ **Local Storage** - Save images directly to device gallery
- ✅ **Social Media Integration using share_plus** - Share images across platforms including Facebook, WhatsApp, and Telegram
- ✅ **Smart Caching using Hive** - Stores up to 20 previous price lists with the ability to modify existing ones instead of starting from scratch

## Installation

You can install the Android APK directly on your device: [Download FeedStock APK](READEME-Assets/built-app/الحنش-للأعلاف.apk)

> [!NOTE]
> Android only - iOS version not currently available

## Development Journey & Learning Process

The initial version of this app relied on overlaying text onto a pre-made price list image template. However, this approach was abandoned due to poor image quality constraints. The current implementation dynamically generates high-quality SVG images, providing much better visual results and greater flexibility.

**Skills Demonstrated:**
- Image processing, generation, and quality optimization
- Android file and storage handling
- Sharing files
- UX design by balancing functionality with simplicity for less tech-savvy users
- Caching and data persistence

## Future Improvements

- **Enhanced Customization** - Allow users to add custom products and package configurations
  - *Note: Currently using fixed product categories to maintain simplicity for users with limited technical experience*
- **Multi-language Support** - Expand beyond Arabic interface
- **Cloud Sync** - Enable price list backup and sync across devices

## License

This project is licensed under the MIT License. See the [LICENSE file](LICENSE.md) for more details.
