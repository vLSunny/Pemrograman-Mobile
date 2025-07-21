import 'package:fitnestx/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen4 extends StatefulWidget {
  const SplashScreen4({super.key});

  @override
  State<SplashScreen4> createState() => _SplashScreen4State();
}

class _SplashScreen4State extends State<SplashScreen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
      ),

      body: SafeArea(
        child: Column(
          children: [

            Image.asset(
              "assets/images/Image2.png",
              height: 490,
              fit: BoxFit.cover,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text("Improve Sleep Quality",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text("Improve the quality of sleep with us, good quality sleep can bring a good mood in the morning.",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeScreen(),
            ),
          );
        },
        backgroundColor: Color(0xFF97B3FE),
        shape: CircleBorder(),
        child: Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.white,
        ),
      ),

      backgroundColor: Colors.white,

    );
  }
}