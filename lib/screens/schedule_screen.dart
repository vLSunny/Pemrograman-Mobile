import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("Workout Schedule",
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
        backgroundColor: Colors.white,
      ),

      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text("July 2025",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.grey,
                      ),

                    ],
                  ),
                ),

                SizedBox(
                  height: 105.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFF8F8F8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                            child: Column(
                              children: [

                                Text("Mon",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("01",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFF8F8F8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                            child: Column(
                              children: [

                                Text("Tue",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("02",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFF8F8F8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                            child: Column(
                              children: [

                                Text("Wed",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("03",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFF8F8F8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                            child: Column(
                              children: [

                                Text("Thus",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("04",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFF8F8F8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                            child: Column(
                              children: [

                                Text("Fri",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("05",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFF8F8F8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                            child: Column(
                              children: [

                                Text("Sat",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("06",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFF8F8F8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                            child: Column(
                              children: [

                                Text("Sun",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("07",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(
                  height: 700.0,
                  child: SfCalendar(
                    view: CalendarView.day,
                    dataSource: WorkoutDataSource(_getWorkoutData()),
                    timeSlotViewSettings: TimeSlotViewSettings(
                      startHour: 6,
                      endHour: 20,
                      timeFormat: 'h:mm a',
                    ),
                    todayHighlightColor: Colors.deepPurple,
                    appointmentTextStyle: TextStyle(color: Colors.white),

                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Text("data"),
                ),

              ],
            ),
          ),
      ),

      backgroundColor: Colors.white,

    );
  }

  List<Appointment> _getWorkoutData() {
    return <Appointment>[
      Appointment(
        startTime: DateTime.now().add(Duration(hours: 1)),
        endTime: DateTime.now().add(Duration(hours: 2)),
        subject: 'Ab Workout',
        color: Colors.pinkAccent,
        startTimeZone: '',
        endTimeZone: '',
      ),
      Appointment(
        startTime: DateTime.now().add(Duration(hours: 3)),
        endTime: DateTime.now().add(Duration(hours: 4)),
        subject: 'Upperbody Workout',
        color: Colors.purpleAccent,
        startTimeZone: '',
        endTimeZone: '',
      ),
      Appointment(
        startTime: DateTime.now().add(Duration(hours: 9)),
        endTime: DateTime.now().add(Duration(hours: 10)),
        subject: 'Lowerbody Workout',
        color: Colors.deepPurple.shade200,
        startTimeZone: '',
        endTimeZone: '',
      ),
    ];
  }
}

class WorkoutDataSource extends CalendarDataSource {
  WorkoutDataSource(List<Appointment> source) {
    appointments = source;
  }
}