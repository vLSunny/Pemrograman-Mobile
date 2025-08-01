import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CaloriesTrackingModal extends StatefulWidget {
  const CaloriesTrackingModal({super.key});

  @override
  State<CaloriesTrackingModal> createState() => _CaloriesTrackingModalState();
}

class _CaloriesTrackingModalState extends State<CaloriesTrackingModal> {
  double selectedCalories = 500; // Default 500 calories
  final TextEditingController _customCaloriesController =
      TextEditingController();
  bool _showCustomInput = false;

  final List<double> quickCalories = [100, 250, 500, 750, 1000, 1500, 2000];

  @override
  void initState() {
    super.initState();
    _customCaloriesController.text = selectedCalories.toString();
  }

  @override
  void dispose() {
    _customCaloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 20),

          Text(
            'Add Calories Burned',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),

          // Quick calories
          Text(
            'Quick Select:',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: 10),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                quickCalories.map((calories) {
                  return ChoiceChip(
                    label: Text('${calories}'),
                    selected: selectedCalories == calories && !_showCustomInput,
                    onSelected: (selected) {
                      setState(() {
                        selectedCalories = calories;
                        _showCustomInput = false;
                      });
                    },
                    selectedColor: Color(0xFF98B3FF),
                    labelStyle: TextStyle(
                      color:
                          selectedCalories == calories && !_showCustomInput
                              ? Colors.white
                              : Colors.black,
                    ),
                  );
                }).toList(),
          ),

          SizedBox(height: 20),

          // Custom calories
          Row(
            children: [
              Checkbox(
                value: _showCustomInput,
                onChanged: (value) {
                  setState(() {
                    _showCustomInput = value ?? false;
                    if (_showCustomInput) {
                      _customCaloriesController.text =
                          selectedCalories.toString();
                    }
                  });
                },
              ),
              Text(
                'Custom amount',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          if (_showCustomInput) ...[
            SizedBox(height: 10),
            TextField(
              controller: _customCaloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Calories burned',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixText: 'cal',
              ),
              onChanged: (value) {
                setState(() {
                  selectedCalories = double.tryParse(value) ?? 0;
                });
              },
            ),
          ],

          SizedBox(height: 30),

          // Add button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF98B3FF),
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                final calories =
                    _showCustomInput
                        ? double.tryParse(_customCaloriesController.text) ?? 0
                        : selectedCalories;

                if (calories > 0) {
                  // For now, we'll just close the modal
                  // In a real implementation, you would call CaloriesService.addCalories(calories)
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Add Calories',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
