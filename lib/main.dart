import 'package:fitnestx/screens/splash_screen_updated.dart';
import 'package:fitnestx/services/local_storage_service.dart';
import 'package:fitnestx/providers/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppSettingsProvider(),
      child: Consumer<AppSettingsProvider>(
        builder: (context, appSettings, child) {
          return MaterialApp(
            title: 'My Fit LifeStyle+',
            themeMode: appSettings.themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: appSettings.themeColor,
                brightness: Brightness.light,
              ),
              useMaterial3: false,
              fontFamily: GoogleFonts.poppins().fontFamily,
              textTheme: GoogleFonts.poppinsTextTheme().copyWith(
                headlineSmall: GoogleFonts.poppins(
                  fontSize: 24 * appSettings.fontSizeFactor,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                bodyMedium: GoogleFonts.poppins(
                  fontSize: 16 * appSettings.fontSizeFactor,
                  color: Colors.black54,
                ),
                titleLarge: GoogleFonts.poppins(
                  fontSize: 20 * appSettings.fontSizeFactor,
                  fontWeight: FontWeight.w600,
                ),
                bodyLarge: GoogleFonts.poppins(
                  fontSize: 18 * appSettings.fontSizeFactor,
                ),
                bodySmall: GoogleFonts.poppins(
                  fontSize: 14 * appSettings.fontSizeFactor,
                ),
              ),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: appSettings.themeColor,
                brightness: Brightness.dark,
              ),
              useMaterial3: false,
              fontFamily: GoogleFonts.poppins().fontFamily,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
              ).copyWith(
                headlineSmall: GoogleFonts.poppins(
                  fontSize: 24 * appSettings.fontSizeFactor,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                bodyMedium: GoogleFonts.poppins(
                  fontSize: 16 * appSettings.fontSizeFactor,
                  color: Colors.white70,
                ),
                titleLarge: GoogleFonts.poppins(
                  fontSize: 20 * appSettings.fontSizeFactor,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                bodyLarge: GoogleFonts.poppins(
                  fontSize: 18 * appSettings.fontSizeFactor,
                  color: Colors.white,
                ),
                bodySmall: GoogleFonts.poppins(
                  fontSize: 14 * appSettings.fontSizeFactor,
                  color: Colors.white70,
                ),
              ),
            ),
            home: const SplashScreenUpdated(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
