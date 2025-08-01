import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'user_first_form_screen.dart';
import 'home_content_screen.dart';
import '../services/user_storage_service.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // Check if user has already set up profile using UserStorageService
    final hasProfile = await UserStorageService.hasUserProfile();

    if (hasProfile) {
      // User has already set up profile, go to home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeContentScreen()),
      );
    } else {
      // First time user, go to form screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserFirstFormScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'FitnestX',
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF92A3FD),
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
