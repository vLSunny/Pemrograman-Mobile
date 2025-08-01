import 'package:flutter/material.dart';

class SleepTrackingChart extends StatefulWidget {
  const SleepTrackingChart({Key? key}) : super(key: key);

  @override
  State<SleepTrackingChart> createState() => _SleepTrackingChartState();
}

class _SleepTrackingChartState extends State<SleepTrackingChart>
    with SingleTickerProviderStateMixin {
  double _currentSleep = 8.33; // 8h 20m in hours
  final double _dailyGoal = 8.0; // 8 hours daily goal
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _updateSleepData();
  }

  void _updateSleepData() {
    _animation = Tween<double>(
      begin: _currentSleep,
      end: _currentSleep,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward(from: 0.0);
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
                  color: Color(0xFF9C27B0).withOpacity(0.1),
                ),
              ),

              SizedBox(
                width: 90,
                height: 90,
                child: CircularProgressIndicator(
                  value: percentage > 1.0 ? 1.0 : percentage,
                  strokeWidth: 8,
                  backgroundColor: Color(0xFFE1BEE7),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9C27B0)),
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
                      color: Color(0xFF9C27B0),
                    ),
                  ),
                  Text(
                    '${animatedValue.toStringAsFixed(1)}h',
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
                    color: Color(0xFF9C27B0),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.bedtime, size: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
