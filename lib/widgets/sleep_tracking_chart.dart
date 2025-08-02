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
                      color: Color(0xFF9C27B0).withOpacity(0.1),
                    ),
                  ),

                  // Progress circle
                  SizedBox(
                    width: circleSize,
                    height: circleSize,
                    child: CircularProgressIndicator(
                      value: percentage > 1.0 ? 1.0 : percentage,
                      strokeWidth: strokeWidth,
                      backgroundColor: Color(0xFFE1BEE7),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF9C27B0),
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
                            color: Color(0xFF9C27B0),
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '${animatedValue.toStringAsFixed(1)}h',
                          style: TextStyle(
                            fontSize: valueFontSize,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Sleep icon
                  Positioned(
                    top: (availableHeight - size) / 2 + size * 0.05,
                    right: (availableWidth - size) / 2 + size * 0.05,
                    child: Container(
                      width: iconSize,
                      height: iconSize,
                      decoration: BoxDecoration(
                        color: Color(0xFF9C27B0),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.bedtime,
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
