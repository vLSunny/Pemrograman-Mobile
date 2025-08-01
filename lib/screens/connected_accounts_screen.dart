import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectedAccountsScreen extends StatefulWidget {
  const ConnectedAccountsScreen({super.key});

  @override
  State<ConnectedAccountsScreen> createState() =>
      _ConnectedAccountsScreenState();
}

class _ConnectedAccountsScreenState extends State<ConnectedAccountsScreen> {
  bool _googleConnected = true;
  bool _facebookConnected = false;
  bool _appleConnected = false;
  bool _twitterConnected = false;
  bool _instagramConnected = false;
  bool _fitbitConnected = false;
  bool _garminConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Connected Accounts",
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Social Media"),
            _buildAccountCard(
              "Google",
              "Connect with Google account",
              _googleConnected,
              Colors.red,
              Icons.g_mobiledata,
              (value) {
                setState(() => _googleConnected = value);
              },
            ),
            const SizedBox(height: 12),
            _buildAccountCard(
              "Facebook",
              "Connect with Facebook account",
              _facebookConnected,
              Colors.blue,
              Icons.facebook,
              (value) {
                setState(() => _facebookConnected = value);
              },
            ),
            const SizedBox(height: 12),
            _buildAccountCard(
              "Apple",
              "Connect with Apple ID",
              _appleConnected,
              Colors.black,
              Icons.apple,
              (value) {
                setState(() => _appleConnected = value);
              },
            ),
            const SizedBox(height: 12),
            _buildAccountCard(
              "Twitter",
              "Connect with Twitter account",
              _twitterConnected,
              Colors.lightBlue,
              Icons.alternate_email,
              (value) {
                setState(() => _twitterConnected = value);
              },
            ),
            const SizedBox(height: 12),
            _buildAccountCard(
              "Instagram",
              "Connect with Instagram account",
              _instagramConnected,
              Colors.purple,
              Icons.camera_alt,
              (value) {
                setState(() => _instagramConnected = value);
              },
            ),

            const SizedBox(height: 32),
            _buildSectionTitle("Fitness Devices"),
            _buildAccountCard(
              "Fitbit",
              "Sync with Fitbit device",
              _fitbitConnected,
              Colors.teal,
              Icons.watch,
              (value) {
                setState(() => _fitbitConnected = value);
              },
            ),
            const SizedBox(height: 12),
            _buildAccountCard(
              "Garmin",
              "Sync with Garmin device",
              _garminConnected,
              Colors.blue[800]!,
              Icons.directions_run,
              (value) {
                setState(() => _garminConnected = value);
              },
            ),

            const SizedBox(height: 32),
            _buildInfoCard(),
          ],
        ),
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

  Widget _buildAccountCard(
    String name,
    String description,
    bool isConnected,
    Color color,
    IconData icon,
    ValueChanged<bool> onChanged,
  ) {
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                if (isConnected)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "Connected",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Switch(value: isConnected, onChanged: onChanged, activeColor: color),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
              const SizedBox(width: 8),
              Text(
                "About Connected Accounts",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "• Connect social media accounts to share your fitness achievements\n• Sync with fitness devices to automatically track your activities\n• Your data is encrypted and secure\n• You can disconnect accounts anytime",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.blue[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
