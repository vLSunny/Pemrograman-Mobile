import 'package:fitnestx/screens/splash_screen3.dart';
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
              height: 55,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF97B3FE), Color(0xFF9AC2FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SplashScreen3(),
                      ),
                    );
                  },
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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