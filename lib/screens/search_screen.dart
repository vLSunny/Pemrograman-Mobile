import 'package:fitnestx/screens/add_alarm_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final List<Map<String, dynamic>> gridItems = [
    {
      'title': 'Dashboard',
      'icon': Icons.dashboard,
    },
    {
      'title': 'Profile',
      'icon': Icons.person,
    },
    {
      'title': 'Settings',
      'icon': Icons.settings,
    },
    {
      'title': 'Notifications',
      'icon': Icons.notifications,
    },
    {
      'title': 'Calendar',
      'icon': Icons.calendar_today,
    },
    {
      'title': 'Logout',
      'icon': Icons.logout,
    },
  ];

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

            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                shadowColor: Colors.grey.withOpacity(0.3),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Color(0XFFF8F8F8),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: List.generate(gridItems.length, (index) {
                    final item = gridItems[index];
                    return InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${item['title']} tapped')),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item['icon'], size: 40, color: Colors.deepPurple),
                            SizedBox(height: 10),
                            Text(
                              item['title'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );

                  }),
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}