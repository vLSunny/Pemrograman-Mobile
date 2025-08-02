import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitnestx/widgets/workout_schedule_tab.dart';

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
        title: Text(
          "Workout Schedule",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),

      body: SafeArea(child: WorkoutScheduleTab()),

      backgroundColor: Colors.white,
    );
  }
}
