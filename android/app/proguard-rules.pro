# Flutter ProGuard Rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Google Fonts
-keep class com.google.android.gms.** { *; }
-keep class com.google.firebase.** { *; }

# Prevent obfuscation of font resources
-keep class ** extends android.graphics.Typeface
-keep class ** extends android.graphics.fonts.Font
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes EnclosingMethod
-keepattributes SourceFile
-keepattributes LineNumberTable

# Keep resource references
-keep class **.R$font { *; }
-keep class **.R$drawable { *; }
-keep class **.R$mipmap { *; }
-keep class **.R$string { *; }

# Keep Flutter wrapper
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }

# Keep platform channels
-keep class * extends io.flutter.plugin.common.MethodChannel.MethodCallHandler { *; }

# Prevent removal of unused classes that might be needed at runtime
-dontwarn io.flutter.embedding.**
-dontwarn io.flutter.plugins.**
