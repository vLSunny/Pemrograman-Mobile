import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/water_service.dart';

class WaterTrackingModal extends StatefulWidget {
  const WaterTrackingModal({super.key});

  @override
  State<WaterTrackingModal> createState() => _WaterTrackingModalState();
}

class _WaterTrackingModalState extends State<WaterTrackingModal> {
  double selectedAmount = 250; // Default 250ml
  final TextEditingController _customAmountController = TextEditingController();
  bool _showCustomInput = false;

  final List<double> quickAmounts = [100, 250, 500, 750, 1000];

  @override
  void dispose() {
    _customAmountController.dispose();
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
            'Add Water Intake',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),

          // Quick amounts
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
                quickAmounts.map((amount) {
                  return ChoiceChip(
                    label: Text('${amount}ml'),
                    selected: selectedAmount == amount && !_showCustomInput,
                    onSelected: (selected) {
                      setState(() {
                        selectedAmount = amount;
                        _showCustomInput = false;
                      });
                    },
                    selectedColor: Color(0xFF98B3FF),
                    labelStyle: TextStyle(
                      color:
                          selectedAmount == amount && !_showCustomInput
                              ? Colors.white
                              : Colors.black,
                    ),
                  );
                }).toList(),
          ),

          SizedBox(height: 20),

          // Custom amount
          Row(
            children: [
              Checkbox(
                value: _showCustomInput,
                onChanged: (value) {
                  setState(() {
                    _showCustomInput = value ?? false;
                    if (_showCustomInput) {
                      _customAmountController.text = selectedAmount.toString();
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
              controller: _customAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount (ml)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixText: 'ml',
              ),
              onChanged: (value) {
                setState(() {
                  selectedAmount = double.tryParse(value) ?? 0;
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
                final amount =
                    _showCustomInput
                        ? double.tryParse(_customAmountController.text) ?? 0
                        : selectedAmount;

                if (amount > 0) {
                  await WaterService.addWaterIntake(amount);
                  WaterService.notifyWaterUpdate();
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Add Water',
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
