@echo off
echo Fixing Android plugin manifest issues...
echo.

:: Clean Flutter cache
echo Cleaning Flutter cache...
flutter clean
flutter pub get

:: Clear pub cache for problematic plugins
echo Clearing pub cache for problematic plugins...
rmdir /s /q "%USERPROFILE%\AppData\Local\Pub\Cache\hosted\pub.dev\flutter_plugin_android_lifecycle-2.0.28"
rmdir /s /q "%USERPROFILE%\AppData\Local\Pub\Cache\hosted\pub.dev\image_picker_android-0.8.12+24"
rmdir /s /q "%USERPROFILE%\AppData\Local\Pub\Cache\hosted\pub.dev\flutter_secure_storage-9.2.4"
rmdir /s /q "%USERPROFILE%\AppData\Local\Pub\Cache\hosted\pub.dev\path_provider_android-2.2.17"

:: Get fresh versions
echo Getting fresh plugin versions...
flutter pub upgrade

:: Build the project
echo Building APK...
flutter build apk --release

echo.
echo Build process completed!
pause
