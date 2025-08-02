import 'package:fitnestx/screens/notifications_screen.dart';
import 'package:fitnestx/screens/air_quality_screen.dart';
import 'package:fitnestx/widgets/todo_list_tab_updated.dart';
import 'package:fitnestx/widgets/bmi_tab.dart';
import 'package:fitnestx/widgets/water_tracking_modal.dart';
import 'package:fitnestx/widgets/water_intake_chart.dart';
import 'package:fitnestx/widgets/sleep_tracking_modal.dart';
import 'package:fitnestx/widgets/calories_tracking_modal.dart';
import 'package:fitnestx/widgets/sleep_tracking_chart.dart';
import 'package:fitnestx/widgets/calories_tracking_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/user_info_widget.dart';
import '../services/water_service.dart';
import '../services/sleep_service.dart';
import '../services/calories_service.dart';

class HomeContentScreen extends StatefulWidget {
  final String userName;
  const HomeContentScreen({super.key, this.userName = 'User'});

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
  void initState() {
    super.initState();
    // Listen to water updates
    WaterService.waterUpdates.listen((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Widget _buildOverallProgress() {
    double waterProgress = (WaterService.getTodayTotal() / 2.5) * 100;
    double sleepProgress = (SleepService.getTodayTotal() / 8.0) * 100;
    double caloriesProgress = (CaloriesService.getTodayTotal() / 2000.0) * 100;

    waterProgress = waterProgress.clamp(0, 100);
    sleepProgress = sleepProgress.clamp(0, 100);
    caloriesProgress = caloriesProgress.clamp(0, 100);

    double overallProgress =
        (waterProgress + sleepProgress + caloriesProgress) / 3;

    Color progressColor;
    if (overallProgress >= 80) {
      progressColor = Colors.green;
    } else if (overallProgress >= 50) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.red;
    }

    return Column(
      children: [
        Text(
          'Overall Daily Progress',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '${overallProgress.toStringAsFixed(0)}%',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: progressColor,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 220,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: overallProgress / 100,
            child: Container(
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Color> _getProgressGradientColors() {
    double waterProgress = (WaterService.getTodayTotal() / 2.5) * 100;
    double sleepProgress = (SleepService.getTodayTotal() / 8.0) * 100;
    double caloriesProgress = (CaloriesService.getTodayTotal() / 2000.0) * 100;

    waterProgress = waterProgress.clamp(0, 100);
    sleepProgress = sleepProgress.clamp(0, 100);
    caloriesProgress = caloriesProgress.clamp(0, 100);

    double overallProgress =
        (waterProgress + sleepProgress + caloriesProgress) / 3;

    if (overallProgress >= 80) {
      return [Colors.white, Colors.green.shade100, Colors.green.shade200];
    } else if (overallProgress >= 50) {
      return [Colors.white, Colors.orange.shade100, Colors.orange.shade200];
    } else {
      return [Colors.white, Colors.red.shade100, Colors.red.shade200];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const UserGreetingWidget(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
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
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "BMI (Body Mass Index)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "You have a normal weight",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              backgroundColor: Colors.pink[200],
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              minimumSize: Size(100, 30),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BMITab(
                                        height:
                                            170.0, // Will be updated with user data
                                        weight:
                                            65.0, // Will be updated with user data
                                      ),
                                ),
                              );
                            },
                            child: Text(
                              "View More",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFE9F0FF),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today's Target",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Icon(
                              Icons.check_circle_outline,
                              color: Color(0xFFA7B9F7),
                              size: 28,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(height: 400, child: TodoListTabUpdated()),
                      ],
                    ),
                  ),
                ),
              ),

              // Air Quality Button
              Padding(
                padding: EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AirQualityScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.air,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Air Quality",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Check real-time air quality",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Three horizontal tracking tabs - Mobile Responsive
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    final isSmallScreen = screenWidth < 400;
                    final cardPadding = isSmallScreen ? 8.0 : 12.0;
                    final titleFontSize = isSmallScreen ? 12.0 : 14.0;
                    final valueFontSize = isSmallScreen ? 14.0 : 16.0;
                    final buttonPadding = isSmallScreen ? 4.0 : 6.0;
                    final chartHeight = isSmallScreen ? 60.0 : 70.0;

                    return Row(
                      children: [
                        // Water Intake Tab
                        Flexible(
                          flex: 1,
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(cardPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Header with title and button
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Water",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: titleFontSize,
                                              color: Colors.blue[800],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Material(
                                          color: Color(0xFF98B3FF),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) {
                                                  return Container(
                                                    height:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.height *
                                                        0.8,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                  25,
                                                                ),
                                                          ),
                                                    ),
                                                    child: WaterTrackingModal(),
                                                  );
                                                },
                                              ).then((_) {
                                                setState(() {});
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: buttonPadding,
                                                vertical: buttonPadding,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.water_drop,
                                                    size:
                                                        isSmallScreen ? 12 : 14,
                                                    color: Colors.white,
                                                  ),
                                                  if (!isSmallScreen) ...[
                                                    SizedBox(width: 2),
                                                    Text(
                                                      '+',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    // Value
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${WaterService.getTodayTotal().toStringAsFixed(1)}L",
                                        style: TextStyle(
                                          fontSize: valueFontSize,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2196F3),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Today",
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 10 : 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    // Chart
                                    Container(
                                      height: chartHeight,
                                      child: WaterIntakeChart(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        // Sleep Tab
                        Flexible(
                          flex: 1,
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purple.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(cardPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Header with title and button
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Sleep",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: titleFontSize,
                                              color: Colors.purple[800],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Material(
                                          color: Color(0xFFD1C4E9),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) {
                                                  return Container(
                                                    height:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.height *
                                                        0.8,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                  25,
                                                                ),
                                                          ),
                                                    ),
                                                    child: SleepTrackingModal(),
                                                  );
                                                },
                                              ).then((_) {
                                                setState(() {});
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: buttonPadding,
                                                vertical: buttonPadding,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.bedtime,
                                                    size:
                                                        isSmallScreen ? 12 : 14,
                                                    color: Colors.white,
                                                  ),
                                                  if (!isSmallScreen) ...[
                                                    SizedBox(width: 2),
                                                    Text(
                                                      '+',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    // Value
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${SleepService.getTodayTotal().toStringAsFixed(1)}h",
                                        style: TextStyle(
                                          fontSize: valueFontSize,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF9C27B0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Today",
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 10 : 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    // Chart
                                    Container(
                                      height: chartHeight,
                                      child: SleepTrackingChart(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        // Calories Tab
                        Flexible(
                          flex: 1,
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(cardPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Header with title and button
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Calories",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: titleFontSize,
                                              color: Colors.orange[800],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Material(
                                          color: Color(0xFFFFCC80),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) {
                                                  return Container(
                                                    height:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.height *
                                                        0.8,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                  25,
                                                                ),
                                                          ),
                                                    ),
                                                    child:
                                                        CaloriesTrackingModal(),
                                                  );
                                                },
                                              ).then((_) {
                                                setState(() {});
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: buttonPadding,
                                                vertical: buttonPadding,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.local_fire_department,
                                                    size:
                                                        isSmallScreen ? 12 : 14,
                                                    color: Colors.white,
                                                  ),
                                                  if (!isSmallScreen) ...[
                                                    SizedBox(width: 2),
                                                    Text(
                                                      '+',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    // Value
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${CaloriesService.getTodayTotal().toStringAsFixed(0)}",
                                        style: TextStyle(
                                          fontSize: valueFontSize,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFF9800),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "kcal",
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 10 : 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    // Chart
                                    Container(
                                      height: chartHeight,
                                      child: CaloriesTrackingChart(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Overall Progress Calculator
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      colors: _getProgressGradientColors(),
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Text(
                          "Overall Daily Progress",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15),
                        _buildOverallProgress(),
                      ],
                    ),
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
