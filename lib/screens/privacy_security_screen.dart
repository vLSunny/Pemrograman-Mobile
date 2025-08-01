import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool _biometricLogin = true;
  bool _twoFactorAuth = false;
  bool _profileVisibility = true;
  bool _dataSharing = false;
  bool _locationTracking = true;
  bool _analyticsData = false;
  bool _autoLock = true;

  String _autoLockTime = "5 minutes";

  final List<String> _autoLockOptions = [
    "Immediately",
    "1 minute",
    "5 minutes",
    "15 minutes",
    "30 minutes",
    "Never",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Privacy & Security",
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
            _buildSectionTitle("Account Security"),
            _buildSecurityCard(),

            const SizedBox(height: 24),
            _buildSectionTitle("Privacy Settings"),
            _buildPrivacyCard(),

            const SizedBox(height: 24),
            _buildSectionTitle("Data & Analytics"),
            _buildDataCard(),

            const SizedBox(height: 24),
            _buildSectionTitle("App Security"),
            _buildAppSecurityCard(),

            const SizedBox(height: 24),
            _buildSectionTitle("Account Actions"),
            _buildAccountActionsCard(),
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

  Widget _buildSecurityCard() {
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
            "Biometric Login",
            "Use fingerprint or face ID to login",
            Icons.fingerprint,
            _biometricLogin,
            (value) => setState(() => _biometricLogin = value),
          ),
          _buildDivider(),
          _buildSwitchTile(
            "Two-Factor Authentication",
            "Add extra security to your account",
            Icons.security,
            _twoFactorAuth,
            (value) => setState(() => _twoFactorAuth = value),
          ),
          _buildDivider(),
          _buildActionTile(
            "Change Password",
            "Update your account password",
            Icons.lock_outline,
            () => _showChangePasswordDialog(),
          ),
          _buildDivider(),
          _buildActionTile(
            "Login Activity",
            "View recent login attempts",
            Icons.history,
            () => _showLoginActivity(),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyCard() {
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
            "Profile Visibility",
            "Make your profile visible to others",
            Icons.visibility,
            _profileVisibility,
            (value) => setState(() => _profileVisibility = value),
          ),
          _buildDivider(),
          _buildSwitchTile(
            "Location Tracking",
            "Allow app to access your location",
            Icons.location_on,
            _locationTracking,
            (value) => setState(() => _locationTracking = value),
          ),
          _buildDivider(),
          _buildActionTile(
            "Blocked Users",
            "Manage blocked users list",
            Icons.block,
            () => _showBlockedUsers(),
          ),
          _buildDivider(),
          _buildActionTile(
            "Privacy Policy",
            "Read our privacy policy",
            Icons.policy,
            () => _showPrivacyPolicy(),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCard() {
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
            "Data Sharing",
            "Share anonymized data for research",
            Icons.share,
            _dataSharing,
            (value) => setState(() => _dataSharing = value),
          ),
          _buildDivider(),
          _buildSwitchTile(
            "Analytics Data",
            "Help improve app with usage data",
            Icons.analytics,
            _analyticsData,
            (value) => setState(() => _analyticsData = value),
          ),
          _buildDivider(),
          _buildActionTile(
            "Download My Data",
            "Export all your personal data",
            Icons.download,
            () => _downloadData(),
          ),
          _buildDivider(),
          _buildActionTile(
            "Data Usage",
            "See how your data is used",
            Icons.info_outline,
            () => _showDataUsage(),
          ),
        ],
      ),
    );
  }

  Widget _buildAppSecurityCard() {
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
            "Auto-Lock",
            "Automatically lock app when inactive",
            Icons.lock_clock,
            _autoLock,
            (value) => setState(() => _autoLock = value),
          ),
          if (_autoLock) ...[
            _buildDivider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.timer, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Auto-Lock Time",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        DropdownButton<String>(
                          value: _autoLockTime,
                          isExpanded: true,
                          underline: Container(),
                          items:
                              _autoLockOptions.map((String time) {
                                return DropdownMenuItem<String>(
                                  value: time,
                                  child: Text(
                                    time,
                                    style: GoogleFonts.poppins(),
                                  ),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _autoLockTime = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          _buildDivider(),
          _buildActionTile(
            "App Permissions",
            "Manage app permissions",
            Icons.admin_panel_settings,
            () => _showAppPermissions(),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountActionsCard() {
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
          _buildActionTile(
            "Deactivate Account",
            "Temporarily disable your account",
            Icons.pause_circle_outline,
            () => _showDeactivateDialog(),
            textColor: Colors.orange,
          ),
          _buildDivider(),
          _buildActionTile(
            "Delete Account",
            "Permanently delete your account",
            Icons.delete_forever,
            () => _showDeleteDialog(),
            textColor: Colors.red,
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

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, color: textColor ?? Colors.blue),
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
                      color: textColor,
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
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey[200], indent: 52);
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Change Password", style: GoogleFonts.poppins()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Current Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "New Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm New Password",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Update"),
              ),
            ],
          ),
    );
  }

  void _showLoginActivity() {
    // Show login activity screen
  }

  void _showBlockedUsers() {
    // Show blocked users screen
  }

  void _showPrivacyPolicy() {
    // Show privacy policy
  }

  void _downloadData() {
    // Download user data
  }

  void _showDataUsage() {
    // Show data usage information
  }

  void _showAppPermissions() {
    // Show app permissions
  }

  void _showDeactivateDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Deactivate Account", style: GoogleFonts.poppins()),
            content: Text(
              "Are you sure you want to deactivate your account? You can reactivate it anytime by logging in.",
              style: GoogleFonts.poppins(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text("Deactivate"),
              ),
            ],
          ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Delete Account", style: GoogleFonts.poppins()),
            content: Text(
              "Are you sure you want to permanently delete your account? This action cannot be undone.",
              style: GoogleFonts.poppins(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Delete"),
              ),
            ],
          ),
    );
  }
}
