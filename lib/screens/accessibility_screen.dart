import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_settings_provider.dart';

class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  bool _highContrast = false;
  bool _largeText = false;
  bool _boldText = false;
  bool _reduceMotion = false;
  bool _screenReader = false;
  bool _voiceOver = false;
  bool _hapticFeedback = true;
  bool _soundEffects = true;
  bool _colorBlindSupport = false;
  double _textScaling = 1.0;
  String _selectedColorScheme = 'Default';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final appSettings = Provider.of<AppSettingsProvider>(context);

    return Scaffold(
      backgroundColor: _highContrast ? Colors.black : Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Accessibility",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: _highContrast ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: _highContrast ? Colors.black : Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: _highContrast ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showAccessibilityInfo(),
            icon: Icon(
              Icons.info_outline,
              color: _highContrast ? Colors.white : Colors.blue,
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAccessibilityOverview(),
              const SizedBox(height: 20),
              _buildVisualAccessibility(),
              const SizedBox(height: 20),
              _buildTextAccessibility(),
              const SizedBox(height: 20),
              _buildMotionAccessibility(),
              const SizedBox(height: 20),
              _buildAudioAccessibility(),
              const SizedBox(height: 20),
              _buildColorAccessibility(),
              const SizedBox(height: 20),
              _buildScreenReaderSupport(),
              const SizedBox(height: 20),
              _buildAccessibilityTips(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccessibilityOverview() {
    int enabledFeatures =
        [
          _highContrast,
          _largeText,
          _boldText,
          _reduceMotion,
          _screenReader,
          _voiceOver,
          _hapticFeedback,
          _soundEffects,
          _colorBlindSupport,
        ].where((feature) => feature).length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              _highContrast
                  ? [Colors.white, Colors.grey[300]!]
                  : [Colors.blue[400]!, Colors.purple[400]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (_highContrast ? Colors.white : Colors.blue).withOpacity(
              0.3,
            ),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.accessibility,
                color: _highContrast ? Colors.black : Colors.white,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                "Accessibility Settings",
                style: GoogleFonts.poppins(
                  color: _highContrast ? Colors.black : Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard(
                  "Features Enabled",
                  "$enabledFeatures",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildOverviewCard(
                  "Text Scale",
                  "${(_textScaling * 100).toInt()}%",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (_highContrast ? Colors.black : Colors.white).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              color: _highContrast ? Colors.black : Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: (_highContrast ? Colors.black : Colors.white).withOpacity(
                0.9,
              ),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisualAccessibility() {
    return _buildSection("Visual Accessibility", Icons.visibility, [
      _buildSwitchTile(
        "High Contrast",
        "Increase contrast for better visibility",
        _highContrast,
        (value) => setState(() => _highContrast = value),
        Icons.contrast,
      ),
      _buildSwitchTile(
        "Large Text",
        "Increase text size throughout the app",
        _largeText,
        (value) => setState(() => _largeText = value),
        Icons.text_fields,
      ),
      _buildSwitchTile(
        "Bold Text",
        "Make text bolder for better readability",
        _boldText,
        (value) => setState(() => _boldText = value),
        Icons.format_bold,
      ),
    ]);
  }

  Widget _buildTextAccessibility() {
    return _buildSection("Text Accessibility", Icons.text_format, [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _highContrast ? Colors.grey[800] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.zoom_in,
                  color: _highContrast ? Colors.white : Colors.blue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Text Scaling",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _highContrast ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "Adjust text size: ${(_textScaling * 100).toInt()}%",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: _highContrast ? Colors.grey[300] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Slider(
              value: _textScaling,
              min: 0.8,
              max: 2.0,
              divisions: 12,
              activeColor: _highContrast ? Colors.white : Colors.blue,
              inactiveColor:
                  _highContrast ? Colors.grey[600] : Colors.grey[300],
              onChanged: (value) => setState(() => _textScaling = value),
            ),
            const SizedBox(height: 8),
            Text(
              "Sample text at current size",
              style: GoogleFonts.poppins(
                fontSize: 14 * _textScaling,
                fontWeight: _boldText ? FontWeight.bold : FontWeight.normal,
                color: _highContrast ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildMotionAccessibility() {
    return _buildSection("Motion & Animation", Icons.animation, [
      _buildSwitchTile(
        "Reduce Motion",
        "Minimize animations and transitions",
        _reduceMotion,
        (value) => setState(() => _reduceMotion = value),
        Icons.motion_photos_off,
      ),
      _buildSwitchTile(
        "Haptic Feedback",
        "Enable vibration feedback for interactions",
        _hapticFeedback,
        (value) => setState(() => _hapticFeedback = value),
        Icons.vibration,
      ),
    ]);
  }

  Widget _buildAudioAccessibility() {
    return _buildSection("Audio Accessibility", Icons.hearing, [
      _buildSwitchTile(
        "Sound Effects",
        "Enable audio feedback for actions",
        _soundEffects,
        (value) => setState(() => _soundEffects = value),
        Icons.volume_up,
      ),
      _buildSwitchTile(
        "VoiceOver Support",
        "Enhanced support for VoiceOver",
        _voiceOver,
        (value) => setState(() => _voiceOver = value),
        Icons.record_voice_over,
      ),
    ]);
  }

  Widget _buildColorAccessibility() {
    return _buildSection("Color Accessibility", Icons.palette, [
      _buildSwitchTile(
        "Color Blind Support",
        "Adjust colors for color vision deficiency",
        _colorBlindSupport,
        (value) => setState(() => _colorBlindSupport = value),
        Icons.color_lens,
      ),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _highContrast ? Colors.grey[800] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.palette,
                  color: _highContrast ? Colors.white : Colors.blue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Color Scheme",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _highContrast ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedColorScheme,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: _highContrast ? Colors.grey[700] : Colors.white,
              ),
              dropdownColor: _highContrast ? Colors.grey[700] : Colors.white,
              style: TextStyle(
                color: _highContrast ? Colors.white : Colors.black,
              ),
              items:
                  [
                    'Default',
                    'Protanopia (Red-blind)',
                    'Deuteranopia (Green-blind)',
                    'Tritanopia (Blue-blind)',
                    'Monochrome',
                  ].map((scheme) {
                    return DropdownMenuItem(value: scheme, child: Text(scheme));
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedColorScheme = value!;
                });
              },
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildScreenReaderSupport() {
    return _buildSection("Screen Reader Support", Icons.screen_search_desktop, [
      _buildSwitchTile(
        "Screen Reader Mode",
        "Optimize for screen reading software",
        _screenReader,
        (value) => setState(() => _screenReader = value),
        Icons.accessibility_new,
      ),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _highContrast ? Colors.grey[800] : Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _highContrast ? Colors.white : Colors.blue[200]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: _highContrast ? Colors.white : Colors.blue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Screen Reader Tips",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _highContrast ? Colors.white : Colors.blue[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "• Use headphones for better audio feedback\n"
              "• Navigate with swipe gestures\n"
              "• Double-tap to activate buttons\n"
              "• Use rotor control for quick navigation",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: _highContrast ? Colors.grey[300] : Colors.blue[600],
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildAccessibilityTips() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _highContrast ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: _highContrast ? Colors.white : Colors.orange,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                "Accessibility Tips",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _highContrast ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTipItem(
            "🔧",
            "Customize settings",
            "Adjust these settings based on your specific needs",
          ),
          _buildTipItem(
            "📱",
            "Device settings",
            "Check your device's accessibility settings for additional options",
          ),
          _buildTipItem(
            "🎧",
            "Audio descriptions",
            "Enable audio descriptions for visual content",
          ),
          _buildTipItem(
            "⌨️",
            "Keyboard navigation",
            "Use keyboard shortcuts for faster navigation",
          ),
          _buildTipItem(
            "🔄",
            "Regular updates",
            "Keep the app updated for the latest accessibility improvements",
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _highContrast ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: _highContrast ? Colors.white : Colors.blue,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _highContrast ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _highContrast ? Colors.grey[700] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: _highContrast ? Colors.white : Colors.blue,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _highContrast ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: _highContrast ? Colors.grey[300] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: _highContrast ? Colors.white : Colors.blue,
            inactiveThumbColor: _highContrast ? Colors.grey[400] : null,
            inactiveTrackColor: _highContrast ? Colors.grey[600] : null,
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String emoji, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _highContrast ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: _highContrast ? Colors.grey[300] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAccessibilityInfo() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: _highContrast ? Colors.grey[800] : Colors.white,
            title: Text(
              "Accessibility Information",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: _highContrast ? Colors.white : Colors.black,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "This app is designed to be accessible to all users. Here are some key features:",
                    style: GoogleFonts.poppins(
                      color: _highContrast ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "• Screen reader compatibility\n"
                    "• High contrast mode\n"
                    "• Adjustable text sizes\n"
                    "• Reduced motion options\n"
                    "• Color blind support\n"
                    "• Keyboard navigation\n"
                    "• Voice control support",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color:
                          _highContrast ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "For additional support, please contact our accessibility team.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: _highContrast ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: _highContrast ? Colors.white : Colors.blue,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Open contact support
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _highContrast ? Colors.white : Colors.blue,
                  foregroundColor: _highContrast ? Colors.black : Colors.white,
                ),
                child: const Text("Contact Support"),
              ),
            ],
          ),
    );
  }
}
