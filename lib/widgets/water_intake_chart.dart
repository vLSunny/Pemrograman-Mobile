import 'package:flutter/material.dart';
import '../services/water_service.dart';

class WaterIntakeChart extends StatefulWidget {
  const WaterIntakeChart({Key? key}) : super(key: key);

  @override
  State<WaterIntakeChart> createState() => _WaterIntakeChartState();
}

class _WaterIntakeChartState extends State<WaterIntakeChart>
    with SingleTickerProviderStateMixin {
  double _currentWater = 0.0;
  final double _dailyGoal = 2.5; // 2.5 liters daily goal
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _updateWaterData();
    // Listen to water updates
    WaterService.waterUpdates.listen((_) {
      if (mounted) {
        _updateWaterData();
      }
    });
  }

  void _updateWaterData() {
    final newValue = WaterService.getTodayTotal();
    _animation = Tween<double>(begin: _currentWater, end: newValue).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward(from: 0.0);

    setState(() {
      _currentWater = newValue;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final animatedValue = _animation.value;
        final percentage = (animatedValue / _dailyGoal).clamp(0.0, 1.0);

        return Container(
          width: 200,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE9F0FF).withOpacity(0.3),
                ),
              ),

              // Progress circle
              SizedBox(
                width: 90,
                height: 90,
                child: CircularProgressIndicator(
                  value: percentage,
                  strokeWidth: 8,
                  backgroundColor: Color(0xFFE9F0FF),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF98B3FF)),
                ),
              ),

              // Center content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(percentage * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF98B3FF),
                    ),
                  ),
                  Text(
                    '${animatedValue.toStringAsFixed(1)}L',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Water drop icon
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Color(0xFF98B3FF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.water_drop, size: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
