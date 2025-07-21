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
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E7),
                      borderRadius: BorderRadius.circular(26.0),
                    ),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 16.0, 0.0, 16.0),
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFF9F9),
                              borderRadius: BorderRadius.circular(36.0), // Rounded corners
                            ),
                            child: Icon(
                                Icons.calendar_month_rounded,
                                //color: Colors.white,
                                size: 40.0
                            ),
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("Reminder!",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0XFFC55258),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text("Next Photos Fall On July 08",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                              ),
                            ),

                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 6.0, right: 20.0),
                          child: Column(
                            children: [
                              Icon(Icons.cancel_outlined),
                              SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEAEEFF),
                      borderRadius: BorderRadius.circular(26.0),
                    ),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Track Your Progress Each",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [

                                  Text("Month With ",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                  Text("Photo",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0XFFA5B4F0),
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.blue[200]),
                                  ),
                                  onPressed: () {},
                                  child: Text("Learn More",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 16.0, 20.0, 16.0),
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFF9F9),
                              borderRadius: BorderRadius.circular(44.0), // Rounded corners
                            ),
                            child: Icon(
                                Icons.calendar_month_rounded,
                                size: 48.0
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFFE9F0FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text("Compare my Photo",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: ElevatedButton(
                            //style: ButtonStyle(backgroundColor: Colors.blue[200]),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blue[200]),
                            ),
                            onPressed: () {},
                            child: Text("Compare",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text("Gallery",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text("See more",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0XFFC7C7C7),
                        ),
                      ),
                    ),

                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Text("",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0XFFC7C7C7),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text("2 June",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0XFFC7C7C7),
                      ),
                    ),
                  ),
                ),
                Text("Images here - 1"),
                ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image.network('data:image/jpeg;base64,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'),
                    SizedBox(width: 10),
                    Image.network('https://example.com/image2.jpg'),
                    SizedBox(width: 10),
                    Image.network('https://example.com/image3.jpg'),
                  ],w
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text("5 May",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0XFFC7C7C7),
                      ),
                    ),
                  ),
                ),
                Text("Images here - 2"),

              ],
            ),
          ),
      ),

    );
  }
}