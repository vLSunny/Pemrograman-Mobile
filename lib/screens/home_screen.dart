import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fitnestx/screens/home_content_screen.dart';
import 'package:fitnestx/screens/profile_screen.dart';
import 'package:fitnestx/screens/progress_screen.dart';
import 'package:fitnestx/screens/schedule_screen.dart';
import 'package:fitnestx/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late AnimationController _rippleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rippleAnimation;

  final List<Widget> _pages = [
    HomeContentScreen(), // Home
    ScheduleScreen(), // Schedule
    SearchScreen(), // Search
    ProgressScreen(), // Progress
    ProfileScreen(), // Profile
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      _rippleController.forward().then((_) {
        _rippleController.reset();
      });
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.95),
              Colors.white.withOpacity(0.98),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
            BoxShadow(
              color: Colors.blue.withOpacity(0.05),
              blurRadius: 40,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: ConvexAppBar(
              style: TabStyle.fixedCircle,
              backgroundColor: Colors.transparent,
              activeColor: const Color(0xFF4A90E2),
              color: Colors.grey.shade400,
              height: 65,
              curveSize: 80,
              top: -25,
              items: [
                TabItem(
                  icon: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _currentIndex == 0 ? _scaleAnimation.value : 1.0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration:
                              _currentIndex == 0
                                  ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        const Color(
                                          0xFF4A90E2,
                                        ).withOpacity(0.3),
                                        Colors.transparent,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF4A90E2,
                                        ).withOpacity(0.4),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  )
                                  : null,
                          child: Icon(
                            Icons.home_filled,
                            size: 28,
                            color:
                                _currentIndex == 0
                                    ? const Color(0xFF4A90E2)
                                    : Colors.grey.shade400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                TabItem(
                  icon: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _currentIndex == 1 ? _scaleAnimation.value : 1.0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration:
                              _currentIndex == 1
                                  ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        const Color(
                                          0xFF4A90E2,
                                        ).withOpacity(0.3),
                                        Colors.transparent,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF4A90E2,
                                        ).withOpacity(0.4),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  )
                                  : null,
                          child: Icon(
                            Icons.calendar_month,
                            size: 28,
                            color:
                                _currentIndex == 1
                                    ? const Color(0xFF4A90E2)
                                    : Colors.grey.shade400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                TabItem(
                  icon: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _currentIndex == 2 ? _scaleAnimation.value : 1.0,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration:
                              _currentIndex == 2
                                  ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFF4A90E2),
                                        const Color(0xFF357ABD),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF4A90E2,
                                        ).withOpacity(0.6),
                                        blurRadius: 20,
                                        spreadRadius: 3,
                                      ),
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.8),
                                        blurRadius: 10,
                                        spreadRadius: -2,
                                        offset: const Offset(0, -2),
                                      ),
                                    ],
                                  )
                                  : BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.grey.shade300,
                                        Colors.grey.shade400,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                          child: Icon(
                            Icons.search,
                            size: 32,
                            color:
                                _currentIndex == 2
                                    ? Colors.white
                                    : Colors.grey.shade600,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                TabItem(
                  icon: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _currentIndex == 3 ? _scaleAnimation.value : 1.0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration:
                              _currentIndex == 3
                                  ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        const Color(
                                          0xFF4A90E2,
                                        ).withOpacity(0.3),
                                        Colors.transparent,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF4A90E2,
                                        ).withOpacity(0.4),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  )
                                  : null,
                          child: Icon(
                            Icons.camera_alt_rounded,
                            size: 28,
                            color:
                                _currentIndex == 3
                                    ? const Color(0xFF4A90E2)
                                    : Colors.grey.shade400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                TabItem(
                  icon: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _currentIndex == 4 ? _scaleAnimation.value : 1.0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration:
                              _currentIndex == 4
                                  ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        const Color(
                                          0xFF4A90E2,
                                        ).withOpacity(0.3),
                                        Colors.transparent,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF4A90E2,
                                        ).withOpacity(0.4),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  )
                                  : null,
                          child: Icon(
                            Icons.person,
                            size: 28,
                            color:
                                _currentIndex == 4
                                    ? const Color(0xFF4A90E2)
                                    : Colors.grey.shade400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              initialActiveIndex: 0,
              onTap: _onTabTapped,
            ),
          ),
        ),
      ),
    );
  }
}
