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

        return LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            final availableHeight = constraints.maxHeight;
            final size =
                (availableWidth < availableHeight
                    ? availableWidth
                    : availableHeight) *
                0.8;
            final circleSize = size * 0.9;
            final strokeWidth = size * 0.08;
            final iconSize = size * 0.2;
            final percentageFontSize = size * 0.18;
            final valueFontSize = size * 0.12;

            return Container(
              width: availableWidth,
              height: availableHeight,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background circle
                  Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE9F0FF).withOpacity(0.3),
                    ),
                  ),

                  // Progress circle
                  SizedBox(
                    width: circleSize,
                    height: circleSize,
                    child: CircularProgressIndicator(
                      value: percentage,
                      strokeWidth: strokeWidth,
                      backgroundColor: Color(0xFFE9F0FF),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF98B3FF),
                      ),
                    ),
                  ),

                  // Center content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '${(percentage * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: percentageFontSize,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF98B3FF),
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '${animatedValue.toStringAsFixed(1)}L',
                          style: TextStyle(
                            fontSize: valueFontSize,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Water drop icon
                  Positioned(
                    top: (availableHeight - size) / 2 + size * 0.05,
                    right: (availableWidth - size) / 2 + size * 0.05,
                    child: Container(
                      width: iconSize,
                      height: iconSize,
                      decoration: BoxDecoration(
                        color: Color(0xFF98B3FF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.water_drop,
                        size: iconSize * 0.6,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
