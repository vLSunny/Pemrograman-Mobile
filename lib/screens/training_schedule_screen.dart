import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingScheduleScreen extends StatefulWidget {
  const TrainingScheduleScreen({super.key});

  @override
  State<TrainingScheduleScreen> createState() => _TrainingScheduleScreenState();
}

class _TrainingScheduleScreenState extends State<TrainingScheduleScreen> {
  Map<String, bool> _selectedDays = {
    'Monday': true,
    'Tuesday': false,
    'Wednesday': true,
    'Thursday': false,
    'Friday': true,
    'Saturday': true,
    'Sunday': false,
  };

  Map<String, TimeOfDay> _workoutTimes = {
    'Monday': const TimeOfDay(hour: 7, minute: 0),
    'Tuesday': const TimeOfDay(hour: 7, minute: 0),
    'Wednesday': const TimeOfDay(hour: 18, minute: 0),
    'Thursday': const TimeOfDay(hour: 7, minute: 0),
    'Friday': const TimeOfDay(hour: 18, minute: 0),
    'Saturday': const TimeOfDay(hour: 9, minute: 0),
    'Sunday': const TimeOfDay(hour: 9, minute: 0),
  };

  Map<String, String> _workoutTypes = {
    'Monday': 'Cardio',
    'Tuesday': 'Rest',
    'Wednesday': 'Strength',
    'Thursday': 'Rest',
    'Friday': 'HIIT',
    'Saturday': 'Yoga',
    'Sunday': 'Rest',
  };

  final List<String> _availableWorkouts = [
    'Cardio',
    'Strength',
    'HIIT',
    'Yoga',
    'Pilates',
    'Swimming',
    'Running',
    'Cycling',
    'Rest',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Training Schedule",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Save",
              style: GoogleFonts.poppins(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWeeklyOverview(),
            const SizedBox(height: 24),
            _buildSectionTitle("Weekly Schedule"),
            ..._buildDayCards(),
            const SizedBox(height: 24),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyOverview() {
    int activeDays = _selectedDays.values.where((active) => active).length;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[400]!, Colors.purple[400]!],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "This Week",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$activeDays",
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "workout days",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${activeDays * 45}",
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "minutes total",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  List<Widget> _buildDayCards() {
    return _selectedDays.keys.map((day) {
      bool isActive = _selectedDays[day]!;
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  isActive ? Colors.blue.withOpacity(0.3) : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green : Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      day,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.black : Colors.grey[500],
                      ),
                    ),
                  ),
                  Switch(
                    value: isActive,
                    onChanged: (value) {
                      setState(() {
                        _selectedDays[day] = value;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ],
              ),
              if (isActive) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildWorkoutTypeDropdown(day)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTimeSelector(day)),
                  ],
                ),
              ],
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildWorkoutTypeDropdown(String day) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _workoutTypes[day],
          isExpanded: true,
          items:
              _availableWorkouts.map((String workout) {
                return DropdownMenuItem<String>(
                  value: workout,
                  child: Text(
                    workout,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                );
              }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _workoutTypes[day] = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildTimeSelector(String day) {
    return GestureDetector(
      onTap: () => _selectTime(day),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text(
              _workoutTimes[day]!.format(context),
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Quick Actions"),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                "Enable All",
                "Turn on all days",
                Icons.check_circle,
                Colors.green,
                () {
                  setState(() {
                    _selectedDays.updateAll((key, value) => true);
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                "Reset",
                "Clear schedule",
                Icons.refresh,
                Colors.orange,
                () {
                  setState(() {
                    _selectedDays.updateAll((key, value) => false);
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                "Templates",
                "Use preset schedules",
                Icons.view_list,
                Colors.blue,
                () => _showTemplates(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                "Reminders",
                "Set notifications",
                Icons.notifications,
                Colors.purple,
                () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subtitle,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(String day) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _workoutTimes[day]!,
    );
    if (picked != null && picked != _workoutTimes[day]) {
      setState(() {
        _workoutTimes[day] = picked;
      });
    }
  }

  void _showTemplates() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Schedule Templates",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTemplateOption("Beginner (3 days)", "Mon, Wed, Fri"),
                _buildTemplateOption(
                  "Intermediate (4 days)",
                  "Mon, Tue, Thu, Sat",
                ),
                _buildTemplateOption("Advanced (5 days)", "Mon-Fri"),
                _buildTemplateOption("Weekend Warrior", "Sat, Sun"),
              ],
            ),
          ),
    );
  }

  Widget _buildTemplateOption(String title, String days) {
    return ListTile(
      title: Text(title, style: GoogleFonts.poppins()),
      subtitle: Text(days, style: GoogleFonts.poppins()),
      onTap: () {
        Navigator.pop(context);
        // Apply template logic here
      },
    );
  }
}
