# 🏋️‍♂️ My Fit LifeStyle+ - Flutter Fitness App

**My Fit LifeStyle+** adalah aplikasi fitness modern yang dibangun dengan Flutter, menghadirkan antarmuka yang elegan dan fungsional untuk pelacakan kebugaran komprehensif. Aplikasi ini menggabungkan desain UI yang indah dari **Fitness App UI Kit for Figma** dengan fungsionalitas lengkap untuk tracking workout, nutrisi, tidur, dan progress kesehatan pengguna.

## 📱 Completed Screens

The following UI/UX screens have been fully implemented in Flutter based on the original Figma design:

- `home_content_screen.dart` – Displays workout/meals/sleep content
- `home_screen.dart` – Main dashboard with navigation
- `login_screen.dart` – User login interface
- `profile_screen.dart` – User profile and settings
- `progress_screen.dart` – Visual progress tracking
- `registration_screen.dart` – New user registration
- `schedule_screen.dart` – Workout or meal schedule view
- `search_screen.dart` – Search functionality across content
- `splash_screen1.dart` – Intro splash screen 1
- `splash_screen2.dart` – Intro splash screen 2
- `welcome_screen.dart` – Initial welcome screen after splash

## ✨ Deskripsi dan Fitur Utama

### 🎯 Fitur Pelacakan Kesehatan
- **💧 Water Intake Tracking** - Pelacakan konsumsi air harian dengan visualisasi chart
- **🔥 Calories Tracking** - Monitor kalori masuk dan keluar dengan grafik interaktif
- **😴 Sleep Monitoring** - Pelacakan pola tidur dan kualitas istirahat
- **🏃‍♂️ Workout Tracker** - Pencatatan latihan dan aktivitas fisik
- **📊 Activity Tracker** - Monitor aktivitas harian dan pencapaian target
- **🌬️ Air Quality Monitor** - Pemantauan kualitas udara lingkungan

### 📱 Fitur Aplikasi
- **🏠 Dashboard Interaktif** - Tampilan utama dengan ringkasan kesehatan
- **📅 Schedule Management** - Penjadwalan workout dan aktivitas
- **🔍 Smart Search** - Pencarian cepat untuk konten dan fitur
- **📈 Progress Tracking** - Visualisasi kemajuan dengan grafik dan chart
- **👤 Profile Management** - Pengaturan profil dan preferensi pengguna
- **🎨 Theme Customization** - Pilihan tema terang/gelap dan warna kustom
- **📝 Goal Setting** - Penetapan dan pelacakan target kesehatan
- **⏰ Smart Alarms** - Pengingat untuk aktivitas dan jadwal
- **🔐 Secure Storage** - Penyimpanan data aman dengan enkripsi

### 🎨 Fitur UI/UX
- ✅ Implementasi pixel-perfect dari desain Figma
- 🎯 Kode Dart modular dengan Flutter best practices
- 📱 Layout responsif untuk berbagai ukuran layar
- 🌈 Adaptive theme dengan dukungan dark/light mode
- ✨ Animasi smooth dan transisi yang elegan
- 🎪 Bottom navigation dengan convex design
- 📊 Chart dan grafik interaktif menggunakan FL Chart dan Syncfusion

## 📦 Plugin FlutterGems yang Digunakan

### 🎨 UI & Design
- **google_fonts: ^6.2.1** - Typography dengan Google Fonts (Poppins)
- **convex_bottom_bar: ^3.2.0** - Bottom navigation bar dengan desain convex
- **adaptive_theme: ^3.7.0** - Dukungan tema adaptif (light/dark mode)

### 📊 Charts & Visualization
- **fl_chart: ^1.0.0** - Library chart interaktif untuk visualisasi data
- **syncfusion_flutter_charts: ^30.1.41** - Chart advanced dari Syncfusion
- **syncfusion_flutter_calendar: ^30.1.41** - Kalender interaktif

### 💾 Data Storage & Management
- **shared_preferences: ^2.5.3** - Penyimpanan data lokal sederhana
- **flutter_secure_storage: ^9.2.4** - Penyimpanan data sensitif dengan enkripsi
- **provider: ^6.1.1** - State management pattern

### 🛠️ Utilities & Services
- **air_quality: ^4.1.1** - API untuk monitoring kualitas udara
- **image_picker: ^1.1.2** - Pengambilan gambar dari kamera/galeri
- **table_calendar: ^3.0.9** - Widget kalender untuk penjadwalan
- **cupertino_icons: ^1.0.8** - Icon set iOS style

### 🧪 Development & Testing
- **flutter_lints: ^6.0.0** - Linting rules untuk kode yang bersih
- **flutter_test** - Framework testing bawaan Flutter

## 🎨 Referensi Open-Source dan Inspirasi

### 📚 Flutter Resources
- **[Applikasi FitnesX](https://github.com/Arman-Gilani/fitnestx)** - Aplikasi FitnesX
- **[Energize](https://codeberg.org/epinez/energize)** - Aplikasi Energize
- **[Fitbook](https://github.com/brandonp2412/fitbook)** - Aplikasi Fitbook

### 🛠️ Plugin & Package References
- **[FL Chart Examples](https://github.com/imaNNeoFighT/fl_chart)** - Inspirasi implementasi chart dan grafik
- **[Syncfusion Flutter Samples](https://github.com/syncfusion/flutter-examples)** - Contoh implementasi Syncfusion widgets
- **[Provider Pattern Examples](https://github.com/flutter/samples/tree/master/provider_shopper)** - Best practices state management dengan Provider

## 🚀 Petunjuk Instalasi

### 📋 Prasyarat
Pastikan Anda telah menginstal:
- **Flutter SDK** (versi 3.7.0 atau lebih baru)
- **Dart SDK** (sudah termasuk dalam Flutter)
- **Android Studio** atau **VS Code** dengan Flutter extension
- **Android SDK** untuk development Android
- **Xcode** untuk development iOS (khusus macOS)

### 🔧 Langkah Instalasi

1. **Clone repository:**
   ```bash
   git clone https://github.com/<your-username>/fitnestx.git
   cd fitnestx
   ```

2. **Verifikasi Flutter installation:**
   ```bash
   flutter doctor
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Generate platform-specific files (jika diperlukan):**
   ```bash
   flutter pub run build_runner build
   ```

5. **Run aplikasi:**
   ```bash
   # Untuk development
   flutter run
   
   # Untuk release mode
   flutter run --release
   
   # Untuk platform spesifik
   flutter run -d android
   flutter run -d ios
   ```

### 📱 Build untuk Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

### 🔧 Troubleshooting
- Jika mengalami masalah dengan dependencies, jalankan: `flutter clean && flutter pub get`
- Untuk masalah Android build: `cd android && ./gradlew clean`
- Untuk masalah iOS build: `cd ios && rm -rf Pods && pod install`

## 📂 Project Structure (Simplified)

```
lib/
├── main.dart
├── screens/           # All UI screens (as listed above)
├── widgets/           # Reusable UI components
├── models/            # Data models (optional)
└── utils/             # Constants, helpers, themes, etc.
```

## 📌 To-Do

* [ ] Implement remaining screens
* [ ] Implement backend/API integration
* [ ] Add state management (Provider/GetX/etc.)
* [ ] Add workout, meal, and sleep data logic
* [ ] Include animations and transitions
* [ ] Improve navigation and routing

## 🙌 Contributing

Contributions are welcome! Feel free to fork the project and open a pull request with enhancements, bug fixes, or new features.

---

> Built with 💙 using Flutter – by \[Rakh]
