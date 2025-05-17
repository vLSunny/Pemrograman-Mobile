import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fitnestx/screens/home_content_screen.dart';
import 'package:fitnestx/screens/profile_screen.dart';
import 'package:fitnestx/screens/progress_screen.dart';
import 'package:fitnestx/screens/schedule_screen.dart';
import 'package:fitnestx/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  final List<Widget> _pages =   [
    HomeContentScreen(),
    ScheduleScreen(),
    SearchScreen(),
    ProgressScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      body: _pages[_currentIndex],

      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        backgroundColor: Colors.white,
        activeColor: Colors.blue.shade800,
        color: Colors.grey,
        items: [
          TabItem(icon: Icon(Icons.home_filled,),),
          TabItem(icon: Icon(Icons.calendar_month,),),
          TabItem(icon: Icon(Icons.search,),),
          TabItem(icon: Icon(Icons.camera_alt_rounded,),),
          TabItem(icon: Icon(Icons.person,),),
        ],
        initialActiveIndex: 0,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

    );
  }
}