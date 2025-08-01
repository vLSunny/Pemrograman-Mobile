import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NutritionGoalsScreen extends StatefulWidget {
  const NutritionGoalsScreen({super.key});

  @override
  State<NutritionGoalsScreen> createState() => _NutritionGoalsScreenState();
}

class _NutritionGoalsScreenState extends State<NutritionGoalsScreen> {
  String _dietType = "Balanced";
  String _goal = "Maintain Weight";
  int _dailyCalories = 2000;
  int _protein = 150;
  int _carbs = 250;
  int _fat = 67;
  int _water = 8;

  final List<String> _dietTypes = [
    "Balanced",
    "Low Carb",
    "High Protein",
    "Keto",
    "Vegetarian",
    "Vegan",
    "Mediterranean",
  ];

  final List<String> _goals = [
    "Lose Weight",
    "Maintain Weight",
    "Gain Weight",
    "Build Muscle",
    "Improve Health",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Nutrition Goals",
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
            _buildSectionTitle("Diet Preferences"),
            _buildDropdownCard("Diet Type", _dietType, _dietTypes, (value) {
              setState(() => _dietType = value!);
            }),
            const SizedBox(height: 16),
            _buildDropdownCard("Primary Goal", _goal, _goals, (value) {
              setState(() => _goal = value!);
            }),

            const SizedBox(height: 32),
            _buildSectionTitle("Daily Targets"),
            _buildCaloriesCard(),

            const SizedBox(height: 24),
            _buildSectionTitle("Macronutrients"),
            _buildMacroCard(),

            const SizedBox(height: 24),
            _buildSectionTitle("Hydration"),
            _buildWaterCard(),

            const SizedBox(height: 24),
            _buildMealPlanCard(),
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

  Widget _buildDropdownCard(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
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
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
        ),
        items:
            items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: GoogleFonts.poppins()),
              );
            }).toList(),
        onChanged: onChanged,
        style: GoogleFonts.poppins(color: Colors.black),
      ),
    );
  }

  Widget _buildCaloriesCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_fire_department, color: Colors.orange, size: 24),
              const SizedBox(width: 12),
              Text(
                "Daily Calories",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$_dailyCalories",
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      "calories per day",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () => setState(() => _dailyCalories += 50),
                    icon: Icon(Icons.add_circle, color: Colors.green),
                  ),
                  IconButton(
                    onPressed:
                        () => setState(
                          () =>
                              _dailyCalories = (_dailyCalories - 50).clamp(
                                1000,
                                5000,
                              ),
                        ),
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroCard() {
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
          _buildMacroRow("Protein", _protein, "g", Colors.red, (value) {
            setState(() => _protein = value);
          }),
          const SizedBox(height: 16),
          _buildMacroRow("Carbs", _carbs, "g", Colors.blue, (value) {
            setState(() => _carbs = value);
          }),
          const SizedBox(height: 16),
          _buildMacroRow("Fat", _fat, "g", Colors.green, (value) {
            setState(() => _fat = value);
          }),
        ],
      ),
    );
  }

  Widget _buildMacroRow(
    String name,
    int value,
    String unit,
    Color color,
    ValueChanged<int> onChanged,
  ) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          "$value$unit",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          children: [
            GestureDetector(
              onTap: () => onChanged(value + 5),
              child: Icon(Icons.keyboard_arrow_up, color: Colors.grey[600]),
            ),
            GestureDetector(
              onTap: () => onChanged((value - 5).clamp(0, 1000)),
              child: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWaterCard() {
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
          Icon(Icons.water_drop, color: Colors.blue, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Water Intake",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "$_water glasses per day",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "$_water",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              GestureDetector(
                onTap: () => setState(() => _water++),
                child: Icon(Icons.add_circle, color: Colors.green),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => setState(() => _water = (_water - 1).clamp(1, 20)),
                child: Icon(Icons.remove_circle, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMealPlanCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[400]!, Colors.teal[400]!],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.restaurant_menu, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Text(
                "Meal Planning",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Get personalized meal plans based on your nutrition goals and dietary preferences.",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Generate Meal Plan",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
