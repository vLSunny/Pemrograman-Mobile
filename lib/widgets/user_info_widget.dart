import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_model.dart';
import '../services/user_storage_service.dart';

class UserInfoWidget extends StatefulWidget {
  final bool showFullInfo;
  final bool showBMI;
  final bool showCalories;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const UserInfoWidget({
    super.key,
    this.showFullInfo = false,
    this.showBMI = false,
    this.showCalories = false,
    this.backgroundColor,
    this.padding,
  });

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  UserModel? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await UserStorageService.getCurrentUser();
      setState(() {
        _currentUser = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        padding: widget.padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_currentUser == null) {
      return Container(
        padding: widget.padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_off, size: 40, color: Colors.grey[400]),
              const SizedBox(height: 8),
              Text(
                "No User Data",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: widget.padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: widget.showFullInfo ? _buildFullInfo() : _buildBasicInfo(),
    );
  }

  Widget _buildBasicInfo() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.blue[400]!, Colors.purple[400]!],
            ),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _currentUser!.name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${_currentUser!.age} years • ${_currentUser!.gender}",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              if (widget.showBMI) ...[
                const SizedBox(height: 4),
                Text(
                  "BMI: ${_currentUser!.bmi.toStringAsFixed(1)} (${_currentUser!.bmiCategory})",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: _getBMIColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFullInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.purple[400]!],
                ),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentUser!.name,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${_currentUser!.age} years old • ${_currentUser!.gender}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _currentUser!.fitnessGoal,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatItem(
                "Height",
                "${_currentUser!.height.toInt()}cm",
                Icons.height,
                Colors.blue,
              ),
            ),
            Expanded(
              child: _buildStatItem(
                "Weight",
                "${_currentUser!.weight.toInt()}kg",
                Icons.monitor_weight,
                Colors.green,
              ),
            ),
            Expanded(
              child: _buildStatItem(
                "Activity",
                _currentUser!.activityLevel,
                Icons.directions_run,
                Colors.orange,
              ),
            ),
          ],
        ),
        if (widget.showBMI) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getBMIColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calculate, color: _getBMIColor(), size: 20),
                const SizedBox(width: 8),
                Text(
                  "BMI: ${_currentUser!.bmi.toStringAsFixed(1)}",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _getBMIColor(),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "(${_currentUser!.bmiCategory})",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: _getBMIColor(),
                  ),
                ),
              ],
            ),
          ),
        ],
        if (widget.showCalories) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.local_fire_department,
                  color: Colors.purple,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Daily Calories: ${_currentUser!.dailyCalorieNeeds.toInt()}",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStatItem(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Color _getBMIColor() {
    if (_currentUser!.bmi < 18.5) return Colors.blue;
    if (_currentUser!.bmi < 25) return Colors.green;
    if (_currentUser!.bmi < 30) return Colors.orange;
    return Colors.red;
  }
}

// Widget untuk menampilkan greeting dengan nama user
class UserGreetingWidget extends StatefulWidget {
  final String? customGreeting;
  final TextStyle? textStyle;

  const UserGreetingWidget({super.key, this.customGreeting, this.textStyle});

  @override
  State<UserGreetingWidget> createState() => _UserGreetingWidgetState();
}

class _UserGreetingWidgetState extends State<UserGreetingWidget> {
  UserModel? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await UserStorageService.getCurrentUser();
      setState(() {
        _currentUser = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        width: 150,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }

    if (_currentUser == null) {
      return Text(
        widget.customGreeting ?? "Welcome!",
        style:
            widget.textStyle ??
            GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      );
    }

    return Text(
      widget.customGreeting ?? "${_getGreeting()}, ${_currentUser!.name}!",
      style:
          widget.textStyle ??
          GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
