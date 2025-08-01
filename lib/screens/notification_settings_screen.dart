import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _pushNotifications = true;
  bool _workoutReminders = true;
  bool _mealReminders = false;
  bool _sleepReminders = true;
  bool _waterReminders = true;
  bool _achievementNotifications = true;
  bool _socialNotifications = false;
  bool _marketingNotifications = false;

  TimeOfDay _quietHoursStart = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _quietHoursEnd = const TimeOfDay(hour: 7, minute: 0);
  bool _quietHoursEnabled = true;

  String _notificationSound = "Default";
  bool _vibration = true;
  bool _ledLight = false;

  final List<String> _soundOptions = [
    "Default",
    "Bell",
    "Chime",
    "Ding",
    "Notification",
    "Silent",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Notification Settings",
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
            onPressed: () {
              Navigator.pop(context);
            },
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
            _buildSectionTitle("General Notifications"),
            _buildNotificationCard(),

            const SizedBox(height: 24),
            _buildSectionTitle("Fitness Reminders"),
            _buildFitnessRemindersCard(),

            const SizedBox(height: 24),
            _buildSectionTitle("Quiet Hours"),
            _buildQuietHoursCard(),

            const SizedBox(height: 24),
            _buildSectionTitle("Notification Style"),
            _buildNotificationStyleCard(),

            const SizedBox(height: 24),
            _buildSectionTitle("Other Notifications"),
            _buildOtherNotificationsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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

  Widget _buildNotificationCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          _buildSwitchTile(
            "Push Notifications",
            "Enable all push notifications",
            Icons.notifications,
            _pushNotifications,
            (value) => setState(() => _pushNotifications = value),
          ),
          _buildDivider(),
          _buildSwitchTile(
            "Achievement Notifications",
            "Get notified when you reach goals",
            Icons.emoji_events,
            _achievementNotifications,
            (value) => setState(() => _achievementNotifications = value),
          ),
          _buildDivider(),
          _buildSwitchTile(
            "Social Notifications",
            "Friend requests and social updates",
            Icons.people,
            _socialNotifications,
            (value) => setState(() => _socialNotifications = value),
          ),
        ],
      ),
    );
  }

  Widget _buildFitnessRemindersCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          _buildSwitchTile(
            "Workout Reminders",
            "Daily workout reminders",
            Icons.fitness_center,
            _workoutReminders,
            (value) => setState(() => _workoutReminders = value),
          ),
          _buildDivider(),
          _buildSwitchTile(
            "Meal Reminders",
            "Healthy eating reminders",
            Icons.restaurant,
            _mealReminders,
            (value) => setState(() => _mealReminders = value),
          ),
          _buildDivider(),
          _buildSwitchTile(
            "Sleep Reminders",
            "Bedtime and wake up reminders",
            Icons.bedtime,
            _sleepReminders,
            (value) => setState(() => _sleepReminders = value),
          ),
          _buildDivider(),
          _buildSwitchTile(
            "Water Reminders",
            "Stay hydrated reminders",
            Icons.local_drink,
            _waterReminders,
            (value) => setState(() => _waterReminders = value),
          ),
        ],
      ),
    );
  }

  Widget _buildQuietHoursCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
              Icon(Icons.do_not_disturb, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enable Quiet Hours",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Disable notifications during specified hours",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _quietHoursEnabled,
                onChanged:
                    (value) => setState(() => _quietHoursEnabled = value),
                activeColor: Colors.blue,
              ),
            ],
          ),
          if (_quietHoursEnabled) ...[
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildTimeSelector(
                    "Start Time",
                    _quietHoursStart,
                    (time) => setState(() => _quietHoursStart = time),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTimeSelector(
                    "End Time",
                    _quietHoursEnd,
                    (time) => setState(() => _quietHoursEnd = time),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNotificationStyleCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.volume_up, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notification Sound",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      DropdownButton<String>(
                        value: _notificationSound,
                        isExpanded: true,
                        underline: Container(),
                        items:
                            _soundOptions.map((String sound) {
                              return DropdownMenuItem<String>(
                                value: sound,
                                child: Text(
                                  sound,
                                  style: GoogleFonts.poppins(),
                                ),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _notificationSound = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildDivider(),
          _buildSwitchTile(
            "Vibration",
            "Vibrate on notifications",
            Icons.vibration,
            _vibration,
            (value) => setState(() => _vibration = value),
          ),
          _buildDivider(),
          _buildSwitchTile(
            "LED Light",
            "Flash LED for notifications",
            Icons.lightbulb_outline,
            _ledLight,
            (value) => setState(() => _ledLight = value),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherNotificationsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          _buildSwitchTile(
            "Marketing Notifications",
            "Promotional offers and updates",
            Icons.campaign,
            _marketingNotifications,
            (value) => setState(() => _marketingNotifications = value),
          ),
          _buildDivider(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.settings, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "System Settings",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Open device notification settings",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
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

  Widget _buildTimeSelector(
    String label,
    TimeOfDay time,
    ValueChanged<TimeOfDay> onChanged,
  ) {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: time,
        );
        if (picked != null && picked != time) {
          onChanged(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              time.format(context),
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey[200], indent: 52);
  }
}
