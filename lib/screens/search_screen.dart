import 'package:fitnestx/screens/add_alarm_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Search",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
        ),
        actions: [

          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAlarmScreen(),
                  ),
                );
              },
              icon: Icon(Icons.alarm),
          ),

        ],
      ),

      body: SafeArea(
          child: Column(
            children: [

              TextFormField(),

            ],
          ),
      ),

    );
  }
}