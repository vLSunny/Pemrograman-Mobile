import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_settings_provider.dart';

class FontSizeScreen extends StatelessWidget {
  const FontSizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettings = Provider.of<AppSettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Font Size",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20 * appSettings.fontSizeFactor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Preview Text",
              style: GoogleFonts.poppins(
                fontSize: 24 * appSettings.fontSizeFactor,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "This is how your text will appear throughout the app with the selected font size.",
              style: GoogleFonts.poppins(
                fontSize: 16 * appSettings.fontSizeFactor,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "Font Size: ${(appSettings.fontSizeFactor * 100).toInt()}%",
              style: GoogleFonts.poppins(
                fontSize: 18 * appSettings.fontSizeFactor,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Slider(
              value: appSettings.fontSizeFactor,
              min: 0.8,
              max: 1.5,
              divisions: 7,
              label: "${(appSettings.fontSizeFactor * 100).toInt()}%",
              onChanged: (value) {
                appSettings.setFontSizeFactor(value);
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPresetButton("Small", 0.8, appSettings),
                _buildPresetButton("Normal", 1.0, appSettings),
                _buildPresetButton("Large", 1.2, appSettings),
                _buildPresetButton("Extra Large", 1.5, appSettings),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetButton(
    String label,
    double factor,
    AppSettingsProvider appSettings,
  ) {
    final isSelected = (appSettings.fontSizeFactor - factor).abs() < 0.01;
    return GestureDetector(
      onTap: () => appSettings.setFontSizeFactor(factor),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12 * appSettings.fontSizeFactor,
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
