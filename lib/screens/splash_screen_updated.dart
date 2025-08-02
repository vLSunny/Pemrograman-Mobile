import 'package:flutter/material.dart';
import 'package:fitnestx/screens/home_screen.dart';
import 'package:fitnestx/screens/user_registration_screen.dart';
import 'package:fitnestx/services/user_storage_service.dart';

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

    try {
      // Check if user is already registered
      final isRegistered = await UserStorageService.isUserRegistered();

      if (!mounted) return;

      if (isRegistered) {
        // User is registered, go directly to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // First time user, show registration form
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserRegistrationScreen(),
          ),
        );
      }
    } catch (e) {
      // If there's an error, show registration screen as fallback
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserRegistrationScreen()),
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
              // App Logo or Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF92A3FD).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(
                  Icons.fitness_center,
                  size: 60,
                  color: Color(0xFF92A3FD),
                ),
              ),
              const SizedBox(height: 40),

              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF92A3FD)),
                strokeWidth: 4,
              ),
              const SizedBox(height: 30),

              Text(
                "Welcome to FitnestX",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Text(
                "Loading your personalized experience...",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
