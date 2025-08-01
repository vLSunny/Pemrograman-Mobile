import 'package:flutter/material.dart';
import 'package:fitnestx/screens/home_screen.dart';
import 'package:fitnestx/screens/user_first_form_screen.dart';

class SplashScreenUpdated extends StatefulWidget {
  const SplashScreenUpdated({super.key});

  @override
  State<SplashScreenUpdated> createState() => _SplashScreenUpdatedState();
}

class _SplashScreenUpdatedState extends State<SplashScreenUpdated> {
  @override
  void initState() {
    super.initState();
    _checkRegistrationStatus();
  }

  Future<void> _checkRegistrationStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    // In a real implementation, you would check registration status here
    // For now, we'll simulate the flow
    final isRegistered =
        true; // Bypass form registration untuk langsung ke HomeScreen

    if (!mounted) return;

    if (isRegistered) {
      // User is registered, go directly to home screen with navigation
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // First time user, show registration form
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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF92A3FD)),
                strokeWidth: 4,
              ),
              const SizedBox(height: 30),
              Text(
                "Welcome to FitnestX",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Loading your personalized experience...",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
