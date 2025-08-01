import 'package:flutter/material.dart';
import '../services/calories_service.dart';

class CaloriesTrackingChart extends StatefulWidget {
  const CaloriesTrackingChart({Key? key}) : super(key: key);

  @override
  State<CaloriesTrackingChart> createState() => _CaloriesTrackingChartState();
}

class _CaloriesTrackingChartState extends State<CaloriesTrackingChart>
    with SingleTickerProviderStateMixin {
  double _currentCalories = 760.0;
  final double _dailyGoal = 2000.0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _updateCaloriesData();
  }

  void _updateCaloriesData() {
    final newValue = CaloriesService.getTodayTotal();
    _animation = Tween<double>(begin: _currentCalories, end: newValue).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward(from: 0.0);

    setState(() {
      _currentCalories = newValue;
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
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFF9800).withOpacity(0.1),
                ),
              ),

              SizedBox(
                width: 90,
                height: 90,
                child: CircularProgressIndicator(
                  value: percentage > 1.0 ? 1.0 : percentage,
                  strokeWidth: 8,
                  backgroundColor: Color(0xFFFFE0B2),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF9800)),
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(percentage * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF9800),
                    ),
                  ),
                  Text(
                    '${animatedValue.toStringAsFixed(0)}kCal',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF9800),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.local_fire_department,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
