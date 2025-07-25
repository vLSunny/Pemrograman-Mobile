import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityTrackerScreen extends StatefulWidget {
  const ActivityTrackerScreen({super.key});

  @override
  State<ActivityTrackerScreen> createState() => _ActivityTrackerScreenState();
}

class _ActivityTrackerScreenState extends State<ActivityTrackerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("Activity Tracker",
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
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    color: Color(0XFFE9F0FF),
                    child: Column(
                      children: [

                        Row(
                          children: [

                            Text("Activity Tracker",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                ),
                            ),

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