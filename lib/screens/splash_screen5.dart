import 'package:fitnestx/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen5 extends StatefulWidget {
  const SplashScreen5({super.key});

  @override
  State<SplashScreen5> createState() => _SplashScreen5State();
}

class _SplashScreen5State extends State<SplashScreen5> {
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
              "assets/images/Image3.png",
              height: 490,
              fit: BoxFit.cover,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text("Get Burn",
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
              child: Text("Let's keep burning, to achieve your goals, it hurts only temporarily, if you give up now you will be in pain forever.",
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