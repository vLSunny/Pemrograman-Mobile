import 'package:fitnestx/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
      ),

      body: Column(
        children: [

          // Text
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Fitnest",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                ),
                // Text
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Text("X",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB3A7E6) //0xFFB3A7E6 final
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Text
          Align(
            alignment: Alignment.center,
            child: Text("Everybody Can Train",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
          ),
          Spacer(),

          // Get Started
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
            child: SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9B51E0), Color(0xFF5B67FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Important to make gradient visible
                    shadowColor: Colors.transparent, // Remove shadow if needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white, // Text remains white
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),

      backgroundColor: Colors.white,

    );

  }
}