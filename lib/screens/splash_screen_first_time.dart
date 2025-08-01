import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_profile_model.dart';
import 'user_first_form_screen.dart';
import 'home_content_screen.dart';

class SplashScreenFirstTime extends StatefulWidget {
  const SplashScreenFirstTime({super.key});

  @override
  State<SplashScreenFirstTime> createState() => _SplashScreenFirstTimeState();
}

class _SplashScreenFirstTimeState extends State<SplashScreenFirstTime> {
  @override
  void initState() {
    super.initState();
    _checkUserData();
  }

  Future<void> _checkUserData() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('current_user');

    if (!mounted) return;

    if (userJson == null) {
      // First time user - show form
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserFirstFormScreen()),
      );
    } else {
      // Existing user - go to home
      final user = UserProfileModel.fromJson(jsonDecode(userJson));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeContentScreen(userName: user.name),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF97B3FE), const Color(0xFF9AC2FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Fitnest",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          "X",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  "Welcome to Your Fitness Journey",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 10.0,
                  ),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
