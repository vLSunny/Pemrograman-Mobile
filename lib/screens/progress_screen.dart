import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../services/workout_service.dart';
import '../models/workout_model.dart';
import 'add_goal_screen.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with TickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList;
  late TabController _tabController;

  // Progress data
  double currentWeight = 75.5;
  double targetWeight = 70.0;
  double bodyFat = 18.5;
  int workoutsCompleted = 24;
  int totalWorkouts = 30;
  double caloriesBurned = 12450.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1800.0,
        maxHeight: 1800.0,
        imageQuality: 85,
      );

      if (pickedFile != null && mounted) {
        setState(() {
          if (_imageFileList == null) {
            _imageFileList = [pickedFile];
          } else {
            _imageFileList!.add(pickedFile);
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
      }
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Add Progress Photo',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Choose how you want to add your progress photo',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              icon: Icon(Icons.camera_alt, color: Color(0xFF6C5CE7)),
              label: Text(
                'Camera',
                style: GoogleFonts.poppins(color: Color(0xFF6C5CE7)),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              icon: Icon(Icons.photo_library, color: Color(0xFF6C5CE7)),
              label: Text(
                'Gallery',
                style: GoogleFonts.poppins(color: Color(0xFF6C5CE7)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Fitness Progress",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3436),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF2D3436)),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  // Navigate to settings screen or show settings dialog
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Settings clicked')));
                },
                icon: Icon(Icons.settings, color: Color(0xFF2D3436)),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Overview Cards
          Container(
            height: 140.0,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: _buildProgressCard(
                    title: "Weight Progress",
                    value: "${currentWeight}kg",
                    target: "Target: ${targetWeight}kg",
                    progress:
                        (targetWeight - currentWeight).abs() /
                        (targetWeight * 0.1),
                    color: Color(0xFF6C5CE7),
                    icon: Icons.monitor_weight,
                  ),
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: _buildProgressCard(
                    title: "Workouts",
                    value: "$workoutsCompleted",
                    target: "of $totalWorkouts",
                    progress: workoutsCompleted / totalWorkouts,
                    color: Color(0xFF00B894),
                    icon: Icons.fitness_center,
                  ),
                ),
              ],
            ),
          ),

          // Tab Navigation
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                ),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Color(0xFF636E72),
              labelStyle: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              tabs: [
                Tab(text: "Overview"),
                Tab(text: "Body"),
                Tab(text: "Workouts"),
                Tab(text: "Goals"),
                Tab(text: "Photos"),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildBodyTab(),
                _buildWorkoutsTab(),
                _buildGoalsTab(),
                _buildPhotosTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to a dedicated Add Goal screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddGoalScreen()),
          );
        },
        backgroundColor: Color(0xFF6C5CE7),
        icon: Icon(Icons.flag, color: Colors.white),
        label: Text(
          'Add Goal',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard({
    required String title,
    required String value,
    required String target,
    required double progress,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${(progress * 100).toInt()}%",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Color(0xFF636E72),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          Text(
            target,
            style: GoogleFonts.poppins(fontSize: 10, color: Color(0xFF636E72)),
          ),
          SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Weekly Summary
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF6C5CE7).withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "This Week",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.trending_up, color: Colors.white, size: 28),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildWeeklyStatItem(
                      "Workouts",
                      "12",
                      Icons.fitness_center,
                    ),
                    _buildWeeklyStatItem(
                      "Calories",
                      "3.2k",
                      Icons.local_fire_department,
                    ),
                    _buildWeeklyStatItem("Hours", "8.5", Icons.access_time),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Achievement Section
          Text(
            "Recent Achievements",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          SizedBox(height: 16),

          _buildAchievementCard(
            title: "Weight Loss Milestone",
            description: "Lost 2kg this month!",
            icon: Icons.emoji_events,
            color: Color(0xFFFDCB6E),
          ),

          _buildAchievementCard(
            title: "Consistency Champion",
            description: "7 days workout streak",
            icon: Icons.local_fire_department,
            color: Color(0xFFE17055),
          ),

          _buildAchievementCard(
            title: "Strength Gain",
            description: "Increased bench press by 5kg",
            icon: Icons.fitness_center,
            color: Color(0xFF00B894),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(height: 8.0),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3436),
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color(0xFF636E72),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Color(0xFF636E72), size: 16),
        ],
      ),
    );
  }

  Widget _buildBodyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Body Metrics
          Text(
            "Body Measurements",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildBodyMetricCard(
                  title: "Weight",
                  value: "${currentWeight}kg",
                  change: "-1.2kg",
                  isPositive: false,
                  color: Color(0xFF6C5CE7),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildBodyMetricCard(
                  title: "Body Fat",
                  value: "${bodyFat}%",
                  change: "-2.1%",
                  isPositive: false,
                  color: Color(0xFFE17055),
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildBodyMetricCard(
                  title: "Muscle Mass",
                  value: "42.3kg",
                  change: "+0.8kg",
                  isPositive: true,
                  color: Color(0xFF00B894),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildBodyMetricCard(
                  title: "BMI",
                  value: "23.1",
                  change: "-0.5",
                  isPositive: false,
                  color: Color(0xFFFDCB6E),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Progress Chart Placeholder
          Container(
            height: 200,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Weight Progress (30 days)",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3436),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.show_chart,
                          size: 48,
                          color: Color(0xFF6C5CE7).withOpacity(0.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Chart will be displayed here",
                          style: GoogleFonts.poppins(color: Color(0xFF636E72)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyMetricCard({
    required String title,
    required String value,
    required String change,
    required bool isPositive,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Color(0xFF636E72),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  color: isPositive ? Color(0xFF00B894) : Color(0xFFE17055),
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          Text(
            change,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isPositive ? Color(0xFF00B894) : Color(0xFFE17055),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutsTab() {
    final completedWorkouts = WorkoutService.getCompletedWorkouts();

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Workout Stats
          Row(
            children: [
              Expanded(
                child: _buildWorkoutStatCard(
                  title: "Completed",
                  value: "$workoutsCompleted",
                  icon: Icons.check_circle,
                  color: Color(0xFF00B894),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildWorkoutStatCard(
                  title: "Calories Burned",
                  value: "${caloriesBurned.toInt()}",
                  icon: Icons.local_fire_department,
                  color: Color(0xFFE17055),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          Text(
            "Recent Workouts",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          SizedBox(height: 16),

          // Recent Workouts List
          if (completedWorkouts.isEmpty)
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fitness_center,
                      size: 48,
                      color: Color(0xFF636E72).withOpacity(0.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "No completed workouts yet",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Color(0xFF636E72),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Start your fitness journey today!",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xFF636E72).withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...completedWorkouts
                .take(5)
                .map((workout) => _buildWorkoutCard(workout)),
        ],
      ),
    );
  }

  Widget _buildWorkoutStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 12, color: Color(0xFF636E72)),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(Workout workout) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF6C5CE7).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.fitness_center,
              color: Color(0xFF6C5CE7),
              size: 24,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3436),
                  ),
                ),
                Text(
                  "${workout.duration} min • ${workout.calories} cal",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color(0xFF636E72),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.check_circle, color: Color(0xFF00B894), size: 20),
        ],
      ),
    );
  }

  Widget _buildGoalsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Goals Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Fitness Goals",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  // Add new goal functionality
                },
                icon: Icon(Icons.add, color: Color(0xFF6C5CE7)),
                label: Text(
                  "Add Goal",
                  style: GoogleFonts.poppins(
                    color: Color(0xFF6C5CE7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Monthly Goal Summary
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00B894), Color(0xFF55EFC4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00B894).withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "December Goals",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.flag, color: Colors.white, size: 28),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "3 of 5 goals completed",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Active Goals
          Text(
            "Active Goals",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          SizedBox(height: 16),

          _buildGoalCard(
            title: "Lose 5kg",
            description: "Target weight: 70kg",
            progress: 0.6,
            isCompleted: false,
            color: Color(0xFF6C5CE7),
            icon: Icons.monitor_weight,
            deadline: "Dec 31, 2024",
          ),

          _buildGoalCard(
            title: "Complete 30 Workouts",
            description: "Workout consistency goal",
            progress: 0.8,
            isCompleted: false,
            color: Color(0xFF00B894),
            icon: Icons.fitness_center,
            deadline: "Dec 31, 2024",
          ),

          _buildGoalCard(
            title: "Run 5K in 25 minutes",
            description: "Improve cardio endurance",
            progress: 0.4,
            isCompleted: false,
            color: Color(0xFFE17055),
            icon: Icons.directions_run,
            deadline: "Jan 15, 2025",
          ),

          SizedBox(height: 24),

          // Completed Goals
          Text(
            "Completed Goals",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          SizedBox(height: 16),

          _buildGoalCard(
            title: "Drink 2L Water Daily",
            description: "30-day hydration challenge",
            progress: 1.0,
            isCompleted: true,
            color: Color(0xFF74B9FF),
            icon: Icons.water_drop,
            deadline: "Completed Nov 30",
          ),

          _buildGoalCard(
            title: "10,000 Steps Daily",
            description: "Daily step goal for a month",
            progress: 1.0,
            isCompleted: true,
            color: Color(0xFFFDCB6E),
            icon: Icons.directions_walk,
            deadline: "Completed Nov 15",
          ),

          SizedBox(height: 24),

          // Goal Categories
          Text(
            "Goal Categories",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildCategoryCard(
                  title: "Weight Loss",
                  count: "2 goals",
                  color: Color(0xFF6C5CE7),
                  icon: Icons.trending_down,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildCategoryCard(
                  title: "Strength",
                  count: "3 goals",
                  color: Color(0xFF00B894),
                  icon: Icons.fitness_center,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildCategoryCard(
                  title: "Cardio",
                  count: "2 goals",
                  color: Color(0xFFE17055),
                  icon: Icons.favorite,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildCategoryCard(
                  title: "Habits",
                  count: "4 goals",
                  color: Color(0xFFFDCB6E),
                  icon: Icons.schedule,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard({
    required String title,
    required String description,
    required double progress,
    required bool isCompleted,
    required Color color,
    required IconData icon,
    required String deadline,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3436),
                      ),
                    ),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xFF636E72),
                      ),
                    ),
                  ],
                ),
              ),
              if (isCompleted)
                Icon(Icons.check_circle, color: Color(0xFF00B894), size: 24)
              else
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${(progress * 100).toInt()}%",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12),
          if (!isCompleted) ...[
            LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(height: 8.0),
          ],
          Text(
            deadline,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isCompleted ? Color(0xFF00B894) : Color(0xFF636E72),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String count,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 12.0),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            count,
            style: GoogleFonts.poppins(fontSize: 12, color: Color(0xFF636E72)),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Progress Photos",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          SizedBox(height: 16),
          _imageFileList == null || _imageFileList!.isEmpty
              ? Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "No progress photos added yet.",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Color(0xFF636E72),
                    ),
                  ),
                ),
              )
              : SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _imageFileList!.length,
                  separatorBuilder: (context, index) => SizedBox(width: 12.0),
                  itemBuilder: (context, index) {
                    final file = _imageFileList![index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        File(file.path),
                        width: 140.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showImageSourceDialog,
            icon: Icon(Icons.add_a_photo),
            label: Text("Add Photo"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6C5CE7),
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
