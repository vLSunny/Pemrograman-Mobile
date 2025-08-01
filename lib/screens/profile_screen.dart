import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_settings_provider.dart';
import 'personal_information_screen.dart';
import 'workout_preferences_screen.dart';
import 'notification_settings_screen.dart';
import 'privacy_security_screen.dart';
import 'account_verification_screen.dart';
import 'connected_accounts_screen.dart';
import 'nutrition_goals_screen.dart';
import 'training_schedule_screen.dart';
import 'help_center_screen.dart';
import 'progress_tracking_screen.dart';
import 'health_conditions_screen.dart';
import 'emergency_contacts_screen.dart';
import 'medications_screen.dart';
import 'allergies_screen.dart';
import 'theme_colors_screen.dart';
import 'font_size_screen.dart';
import 'accessibility_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _fabController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _fabAnimation;

  bool _isEditing = false;
  bool _notificationsEnabled = true;
  bool _workoutReminders = true;
  bool _sleepReminders = true;
  bool _isDarkMode = false;

  TextEditingController _nameController = TextEditingController(text: "Rakha");
  TextEditingController _bioController = TextEditingController(
    text: "Fitness enthusiast 💪",
  );
  TextEditingController _heightController = TextEditingController(text: "180");
  TextEditingController _weightController = TextEditingController(text: "65");
  TextEditingController _ageController = TextEditingController(text: "22");

  double _profileCompletion = 0.75;
  String _fitnessLevel = "Intermediate";
  double _bmi = 20.1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _fabAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fabController, curve: Curves.elasticOut),
    );

    _animationController.forward();
    _fabController.forward();
    _calculateBMI();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fabController.dispose();
    _nameController.dispose();
    _bioController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    double height = double.tryParse(_heightController.text) ?? 180;
    double weight = double.tryParse(_weightController.text) ?? 65;
    setState(() {
      _bmi = weight / ((height / 100) * (height / 100));
    });
  }

  Color _getBMIColor() {
    if (_bmi < 18.5) return Colors.blue;
    if (_bmi < 25) return Colors.green;
    if (_bmi < 30) return Colors.orange;
    return Colors.red;
  }

  String _getBMICategory() {
    if (_bmi < 18.5) return "Underweight";
    if (_bmi < 25) return "Normal";
    if (_bmi < 30) return "Overweight";
    return "Obese";
  }

  @override
  Widget build(BuildContext context) {
    final appSettings = Provider.of<AppSettingsProvider>(context);
    return Scaffold(
      backgroundColor:
          appSettings.themeMode == ThemeMode.dark
              ? Colors.grey[900]
              : Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Column(
                      children: [
                        _buildProfileHeader(),
                        _buildProfileCompletion(),
                        _buildStatsCards(),
                        _buildQuickActions(),
                        _buildAccountSection(),
                        _buildFitnessPreferences(),
                        _buildNotificationSettings(),
                        _buildAppearanceSettings(),
                        _buildHealthMetrics(),
                        _buildPrivacySection(),
                        _buildSupportSection(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButtons(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: _isDarkMode ? Colors.grey[850] : Colors.white,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:
                  _isDarkMode
                      ? [Colors.grey[850]!, Colors.grey[900]!]
                      : [Colors.blue[50]!, Colors.white],
            ),
          ),
        ),
      ),
      leading: _buildAppBarButton(Icons.arrow_back_ios_new_rounded, () {}),
      actions: [
        _buildAppBarButton(Icons.share_rounded, () {}),
        _buildAppBarButton(Icons.more_vert_rounded, () {}),
      ],
    );
  }

  Widget _buildAppBarButton(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: _isDarkMode ? Colors.grey[800] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: _isDarkMode ? Colors.white : Colors.black),
          iconSize: 20,
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () => _showImagePicker(),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.blue[400]!, Colors.purple[400]!],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _isEditing
                        ? TextField(
                          controller: _nameController,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: _isDarkMode ? Colors.white : Colors.black,
                          ),
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            isDense: true,
                          ),
                        )
                        : Text(
                          _nameController.text,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: _isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                    const SizedBox(height: 4),
                    _isEditing
                        ? TextField(
                          controller: _bioController,
                          style: TextStyle(
                            color:
                                _isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.grey[600],
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            isDense: true,
                          ),
                        )
                        : Text(
                          _bioController.text,
                          style: TextStyle(
                            color:
                                _isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Active",
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _fitnessLevel,
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
                icon: Icon(
                  _isEditing ? Icons.check : Icons.edit,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCompletion() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[400]!, Colors.purple[400]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
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
                "Profile Completion",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${(_profileCompletion * 100).toInt()}%",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: _profileCompletion,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Complete your profile to unlock all features",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              "Height",
              "${_heightController.text}cm",
              Icons.height,
              Colors.blue,
              _heightController,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              "Weight",
              "${_weightController.text}kg",
              Icons.monitor_weight,
              Colors.green,
              _weightController,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              "Age",
              "${_ageController.text}yo",
              Icons.cake,
              Colors.orange,
              _ageController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    TextEditingController controller,
  ) {
    return GestureDetector(
      onTap: () => _showEditDialog(title, controller),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  "BMI Calculator",
                  "${_bmi.toStringAsFixed(1)}",
                  _getBMICategory(),
                  _getBMIColor(),
                  Icons.calculate,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionCard(
                  "Fitness Goal",
                  "Lose 5kg",
                  "In Progress",
                  Colors.purple,
                  Icons.flag,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    String title,
    String value,
    String subtitle,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return _buildSection("Account & Profile", [
      _buildMenuItem(
        Icons.person_outline,
        "Personal Information",
        "Edit your basic details",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PersonalInformationScreen(),
            ),
          );
        },
      ),
      _buildMenuItem(
        Icons.security,
        "Privacy & Security",
        "Manage your privacy settings",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PrivacySecurityScreen(),
            ),
          );
        },
      ),
      _buildMenuItem(
        Icons.verified_user,
        "Account Verification",
        "Verify your account",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AccountVerificationScreen(),
            ),
          );
        },
      ),
      _buildMenuItem(
        Icons.link,
        "Connected Accounts",
        "Link social media accounts",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConnectedAccountsScreen(),
            ),
          );
        },
      ),
    ]);
  }

  Widget _buildFitnessPreferences() {
    return _buildSection("Fitness Preferences", [
      _buildMenuItem(
        Icons.fitness_center,
        "Workout Preferences",
        "Set your workout goals",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WorkoutPreferencesScreen(),
            ),
          );
        },
      ),
      _buildMenuItem(
        Icons.restaurant,
        "Nutrition Goals",
        "Manage your diet plan",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NutritionGoalsScreen(),
            ),
          );
        },
      ),
      _buildMenuItem(
        Icons.schedule,
        "Training Schedule",
        "Set your workout times",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TrainingScheduleScreen(),
            ),
          );
        },
      ),
      _buildMenuItem(
        Icons.trending_up,
        "Progress Tracking",
        "View your fitness journey",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProgressTrackingScreen(),
            ),
          );
        },
      ),
    ]);
  }

  Widget _buildNotificationSettings() {
    return _buildSection("Notifications", [
      _buildMenuItem(
        Icons.notifications,
        "Notification Settings",
        "Manage all notification preferences",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationSettingsScreen(),
            ),
          );
        },
      ),
      _buildSwitchItem(
        "Push Notifications",
        "Receive app notifications",
        _notificationsEnabled,
        (value) {
          setState(() => _notificationsEnabled = value);
        },
      ),
      _buildSwitchItem(
        "Workout Reminders",
        "Get reminded about workouts",
        _workoutReminders,
        (value) {
          setState(() => _workoutReminders = value);
        },
      ),
      _buildSwitchItem(
        "Sleep Reminders",
        "Get reminded about sleep",
        _sleepReminders,
        (value) {
          setState(() => _sleepReminders = value);
        },
      ),
    ]);
  }

  Widget _buildAppearanceSettings() {
    return _buildSection("Appearance & Accessibility", [
      _buildSwitchItem("Dark Mode", "Use dark theme", _isDarkMode, (value) {
        setState(() => _isDarkMode = value);
      }),
      _buildMenuItem(Icons.palette, "Theme Colors", "Customize app colors", () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ThemeColorsScreen()),
        );
      }),
      _buildMenuItem(Icons.text_fields, "Font Size", "Adjust text size", () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FontSizeScreen()),
        );
      }),
      _buildMenuItem(
        Icons.accessibility,
        "Accessibility",
        "Accessibility options",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AccessibilityScreen(),
            ),
          );
        },
      ),
    ]);
  }

  Widget _buildHealthMetrics() {
    return _buildSection("Health & Medical", [
      _buildMenuItem(
        Icons.medical_services,
        "Health Conditions",
        "Manage medical conditions",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HealthConditionsScreen(),
            ),
          );
        },
      ),
      _buildMenuItem(
        Icons.local_hospital,
        "Emergency Contacts",
        "Set emergency contacts",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmergencyContactsScreen(),
            ),
          );
        },
      ),
      _buildMenuItem(
        Icons.medication,
        "Medications",
        "Track your medications",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MedicationsScreen()),
          );
        },
      ),
      _buildMenuItem(Icons.healing, "Allergies", "Manage your allergies", () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AllergiesScreen()),
        );
      }),
    ]);
  }

  Widget _buildPrivacySection() {
    return _buildSection("Data & Privacy", [
      _buildMenuItem(
        Icons.download,
        "Export Data",
        "Download your data",
        () {},
      ),
      _buildMenuItem(
        Icons.backup,
        "Backup & Sync",
        "Manage data backup",
        () {},
      ),
      _buildMenuItem(
        Icons.delete_forever,
        "Delete Account",
        "Permanently delete account",
        () {},
      ),
      _buildMenuItem(
        Icons.policy,
        "Privacy Policy",
        "Read our privacy policy",
        () {},
      ),
    ]);
  }

  Widget _buildSupportSection() {
    return _buildSection("Support & About", [
      _buildMenuItem(
        Icons.help_outline,
        "Help Center",
        "Get help and support",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HelpCenterScreen()),
          );
        },
      ),
      _buildMenuItem(
        Icons.feedback,
        "Send Feedback",
        "Share your feedback",
        () {},
      ),
      _buildMenuItem(
        Icons.star_rate,
        "Rate App",
        "Rate us on app store",
        () {},
      ),
      _buildMenuItem(
        Icons.info_outline,
        "About",
        "App version and info",
        () {},
      ),
    ]);
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.blue, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: _isDarkMode ? Colors.grey[400] : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.notifications, color: Colors.blue, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged, activeColor: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButtons() {
    return ScaleTransition(
      scale: _fabAnimation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "edit",
            mini: true,
            backgroundColor: Colors.blue,
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            child: Icon(
              _isEditing ? Icons.check : Icons.edit,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "settings",
            backgroundColor: Colors.purple,
            onPressed: () {},
            child: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _isDarkMode ? Colors.grey[850] : Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Change Profile Photo",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildImageOption(
                        Icons.camera_alt,
                        "Camera",
                        () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildImageOption(
                        Icons.photo_library,
                        "Gallery",
                        () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
    );
  }

  Widget _buildImageOption(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.blue, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(String title, TextEditingController controller) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: _isDarkMode ? Colors.grey[850] : Colors.white,
            title: Text(
              "Edit $title",
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                labelText: title,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => _calculateBMI(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _calculateBMI();
                  });
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }
}
