import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeContentScreen extends StatefulWidget {
  const HomeContentScreen({super.key});

  @override
  State<HomeContentScreen> createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends State<HomeContentScreen> {

  List<Map<String, double>> chartData = [
    {'x': 0, 'y': 75},
    {'x': 1, 'y': 78},
    {'x': 2, 'y': 72},
    {'x': 3, 'y': 80},
    {'x': 4, 'y': 74},
    {'x': 5, 'y': 79},
    {'x': 6, 'y': 77},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back,",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Text("Stefani Wong",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),
          ],
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
                icon: Icon(Icons.notification_important, color: Colors.black,),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blue[200],
                  ),
                  width: double.infinity,
                  //color: Colors.blue[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text("BMI (Body Mass Index)",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text("You have a normal weight",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                backgroundColor: Colors.pink[200],
                              ),
                              onPressed: () {},
                              child: Text("View More",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                backgroundColor: Colors.pink[200],
                              ),
                              onPressed: () {},
                              child: Text("View More",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
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
                        child: Text("Today's Target",
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
                            child: Text("Check",
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

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                  child: Text("Activity Status",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFE9F0FF),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                        child: Text("Heart Rate",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                        child: Text("78 BPM",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA7B9F7),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 100,
                        child: SfCartesianChart(
                          backgroundColor: Colors.transparent,
                          plotAreaBorderWidth: 0,
                          primaryXAxis: NumericAxis(isVisible: false),
                          primaryYAxis: NumericAxis(isVisible: false),
                          margin: EdgeInsets.zero,
                          series: <FastLineSeries<Map<String, double>, double>>[
                            FastLineSeries<Map<String, double>, double>(
                              dataSource: chartData,
                              xValueMapper: (data, _) => data['x']!,
                              yValueMapper: (data, _) => data['y']!,
                              color: Colors.purpleAccent,
                              width: 2,
                              markerSettings: MarkerSettings(isVisible: false),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    child: Row(
                      children: [

                        Column(
                          children: [


                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Container(
                                width: 35,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xFFf8f8f8),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Container(
                                width: 35,
                                height: 200,
                                //color: Color(0xFFb4befd),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFb9adfa), Color(0xFFb4befd)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20),),
                                ),
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),

                  Column(
                    children: [


                      Container(
                        width: 10,
                        height: 100,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 10,
                        height: 100,
                        color: Colors.blue,
                      ),

                    ],
                  ),

                ],
              ),

              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 10,
                  child: LinearProgressIndicator(
                    value: 0.35, // percent filled
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    backgroundColor: Color(0xFFFFDAB8),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),

      backgroundColor: Colors.white,

    );
  }
}