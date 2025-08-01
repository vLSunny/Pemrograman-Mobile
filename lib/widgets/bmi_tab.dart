import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMITab extends StatefulWidget {
  final double height;
  final double weight;

  const BMITab({super.key, required this.height, required this.weight});

  @override
  State<BMITab> createState() => _BMITabState();
}

class _BMITabState extends State<BMITab> {
  double get bmi {
    if (widget.height <= 0 || widget.weight <= 0) return 0;
    return widget.weight / ((widget.height / 100) * (widget.height / 100));
  }

  String get bmiCategory {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  Color get bmiColor {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Details',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BMI Card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: bmiColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: bmiColor),
              ),
              child: Column(
                children: [
                  Text(
                    'Your BMI',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    bmi.toStringAsFixed(1),
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: bmiColor,
                    ),
                  ),
                  Text(
                    bmiCategory,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: bmiColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // BMI Scale
            Text(
              'BMI Scale',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 60,
              child: Row(
                children: [
                  _buildBMIScaleSegment('Underweight', Colors.blue, bmi < 18.5),
                  _buildBMIScaleSegment(
                    'Normal',
                    Colors.green,
                    bmi >= 18.5 && bmi < 25,
                  ),
                  _buildBMIScaleSegment(
                    'Overweight',
                    Colors.orange,
                    bmi >= 25 && bmi < 30,
                  ),
                  _buildBMIScaleSegment('Obese', Colors.red, bmi >= 30),
                ],
              ),
            ),
            SizedBox(height: 30),

            // User Details
            Text(
              'Your Details',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            _buildDetailRow('Height', '${widget.height.toStringAsFixed(1)} cm'),
            _buildDetailRow('Weight', '${widget.weight.toStringAsFixed(1)} kg'),
            _buildDetailRow('BMI', bmi.toStringAsFixed(1)),
            _buildDetailRow('Status', bmiCategory),
          ],
        ),
      ),
    );
  }

  Widget _buildBMIScaleSegment(String label, Color color, bool isActive) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isActive ? color : color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
