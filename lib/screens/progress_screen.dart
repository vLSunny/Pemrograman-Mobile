import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /*appBar: AppBar(
        leading: IconButton(
          color: Colors.blue,
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Progress Photo",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
        ),
        centerTitle: true,
      ),*/

      appBar: AppBar(
        centerTitle: true,
        title: Text("Progress Photo",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_horiz_rounded, color: Colors.black,),
              ),
            ),
          ),
        ],
      ),


      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  child: Container(
                    color: Color(0xFFFFE6E7),
                    width: double.infinity,
                    height: 200,
                    child: Row(
                      children: [

                        Column(
                          children: [



                          ],
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
      ),

    );
  }
}