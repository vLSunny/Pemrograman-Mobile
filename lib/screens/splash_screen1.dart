import 'package:fitnestx/screens/splash_screen2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        //Background color code
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF97B3FE), Color(0xFF9AC2FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        SafeArea(
          child: Scaffold(

            backgroundColor: Colors.transparent,

            //Main Content code (Text and Button)
            body: Column(
              children: [

                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // Text
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
                                color: Colors.white
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
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashScreen2(),
                          ),
                        );
                      },
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Color(0xFF97B3FE), Color(0xFF9AC2FF)],
                        ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height),),
                        child: Text("Get Started",
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

          ),
        ),

      ],
    );
  }
}