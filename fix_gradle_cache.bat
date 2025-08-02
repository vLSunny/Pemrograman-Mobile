@echo off
echo Fixing Gradle cache and Java compatibility issues...
echo.

REM Step 1: Stop any running Gradle processes
echo Stopping Gradle processes...
taskkill /f /im java.exe 2>nul
taskkill /f /im gradle.exe 2>nul
taskkill /f /im gradlew.exe 2>nul

REM Step 2: Clean cache directories (with retry)
echo Cleaning Gradle cache...
timeout /t 2 /nobreak >nul
rmdir /s /q "%USERPROFILE%\.gradle\caches" 2>nul
rmdir /s /q "%USERPROFILE%\.gradle\daemon" 2>nul
rmdir /s /q "%USERPROFILE%\.gradle\native" 2>nul

REM Step 3: Update Gradle wrapper
echo Updating Gradle wrapper...
echo distributionBase=GRADLE_USER_HOME > "android\gradle\wrapper\gradle-wrapper.properties"
echo distributionPath=wrapper/dists >> "android\gradle\wrapper\gradle-wrapper.properties"
echo zipStoreBase=GRADLE_USER_HOME >> "android\gradle\wrapper\gradle-wrapper.properties"
echo zipStorePath=wrapper/dists >> "android\gradle\wrapper\gradle-wrapper.properties"
echo distributionUrl=https\://services.gradle.org/distributions/gradle-8.5-all.zip >> "android\gradle\wrapper\gradle-wrapper.properties"

REM Step 4: Update Java version compatibility
echo Updating Java version compatibility...
echo org.gradle.jvmargs=-Xmx8G -XX:MaxMetaspaceSize=4G -XX:ReservedCodeCacheSize=512m -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8 > "android\gradle.properties"
echo android.useAndroidX=true >> "android\gradle.properties"
echo android.enableJetifier=true >> "android\gradle.properties"

REM Step 5: Update Java version in build.gradle
echo Updating Java version in build.gradle...
powershell -Command "(Get-Content 'android\app\build.gradle.kts') -replace 'JavaVersion.VERSION_11', 'JavaVersion.VERSION_17' | Set-Content 'android\app\build.gradle.kts'"
powershell -Command "(Get-Content 'android\app\build.gradle.kts') -replace 'jvmTarget = JavaVersion.VERSION_11.toString()', 'jvmTarget = JavaVersion.VERSION_17.toString()' | Set-Content 'android\app\build.gradle.kts'"

echo.
echo Gradle cache fix complete!
echo.
echo Next steps:
echo 1. Close all VS Code instances
echo 2. Run this script: fix_gradle_cache.bat
echo 3. Restart VS Code
echo 4. Run: flutter clean
echo 5. Run: flutter pub get
echo 6. Run: flutter build apk
pause
