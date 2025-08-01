import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SleepTrackingModal extends StatefulWidget {
  const SleepTrackingModal({super.key});

  @override
  State<SleepTrackingModal> createState() => _SleepTrackingModalState();
}

class _SleepTrackingModalState extends State<SleepTrackingModal> {
  double selectedHours = 8; // Default 8 hours
  final TextEditingController _customHoursController = TextEditingController();
  bool _showCustomInput = false;

  final List<double> quickHours = [3, 4, 5, 6, 7, 8, 9, 10];

  @override
  void initState() {
    super.initState();
    _customHoursController.text = selectedHours.toString();
  }

  @override
  void dispose() {
    _customHoursController.dispose();
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
            'Add Sleep Duration',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),

          // Quick hours
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
                quickHours.map((hours) {
                  return ChoiceChip(
                    label: Text('${hours}h'),
                    selected: selectedHours == hours && !_showCustomInput,
                    onSelected: (selected) {
                      setState(() {
                        selectedHours = hours;
                        _showCustomInput = false;
                      });
                    },
                    selectedColor: Color(0xFF98B3FF),
                    labelStyle: TextStyle(
                      color:
                          selectedHours == hours && !_showCustomInput
                              ? Colors.white
                              : Colors.black,
                    ),
                  );
                }).toList(),
          ),

          SizedBox(height: 20),

          // Custom hours
          Row(
            children: [
              Checkbox(
                value: _showCustomInput,
                onChanged: (value) {
                  setState(() {
                    _showCustomInput = value ?? false;
                    if (_showCustomInput) {
                      _customHoursController.text = selectedHours.toString();
                    }
                  });
                },
              ),
              Text(
                'Custom duration',
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
              controller: _customHoursController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Duration (hours)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixText: 'hours',
              ),
              onChanged: (value) {
                setState(() {
                  selectedHours = double.tryParse(value) ?? 0;
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
                final hours =
                    _showCustomInput
                        ? double.tryParse(_customHoursController.text) ?? 0
                        : selectedHours;

                if (hours > 0) {
                  // For now, we'll just close the modal
                  // In a real implementation, you would call SleepService.addSleep(hours)
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Add Sleep',
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
