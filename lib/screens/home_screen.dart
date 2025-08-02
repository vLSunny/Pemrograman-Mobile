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
  // late Animation<double> _rippleAnimation;

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

    // _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    // );
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
      backgroundColor: const Color(0xFFF8FAFC),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.white.withOpacity(0.95)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 32,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: const Color(0xFF4A90E2).withOpacity(0.12),
              blurRadius: 24,
              offset: const Offset(0, 4),
              spreadRadius: -4,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: ConvexAppBar(
              style: TabStyle.fixedCircle,
              backgroundColor: Colors.transparent,
              activeColor: Colors.white,
              color: const Color(0xFF64748B),
              height: 72,
              curveSize: 90,
              top: -28,
              items: [
                TabItem(
                  icon: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _currentIndex == 0 ? _scaleAnimation.value : 1.0,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration:
                              _currentIndex == 0
                                  ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFF667EEA),
                                        const Color(0xFF764BA2),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF667EEA,
                                        ).withOpacity(0.4),
                                        blurRadius: 20,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 8),
                                      ),
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.9),
                                        blurRadius: 8,
                                        spreadRadius: -2,
                                        offset: const Offset(0, -2),
                                      ),
                                    ],
                                  )
                                  : BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                  ),
                          child: Icon(
                            Icons.home_rounded,
                            size: 26,
                            color:
                                _currentIndex == 0
                                    ? Colors.white
                                    : const Color(0xFF64748B),
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
                          padding: const EdgeInsets.all(10),
                          decoration:
                              _currentIndex == 1
                                  ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFF667EEA),
                                        const Color(0xFF764BA2),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF667EEA,
                                        ).withOpacity(0.4),
                                        blurRadius: 20,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 8),
                                      ),
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.9),
                                        blurRadius: 8,
                                        spreadRadius: -2,
                                        offset: const Offset(0, -2),
                                      ),
                                    ],
                                  )
                                  : BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                  ),
                          child: Icon(
                            Icons.calendar_today_rounded,
                            size: 26,
                            color:
                                _currentIndex == 1
                                    ? Colors.white
                                    : const Color(0xFF64748B),
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
                          padding: const EdgeInsets.all(14),
                          decoration:
                              _currentIndex == 2
                                  ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFF667EEA),
                                        const Color(0xFF764BA2),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF667EEA,
                                        ).withOpacity(0.5),
                                        blurRadius: 28,
                                        spreadRadius: 4,
                                        offset: const Offset(0, 12),
                                      ),
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.95),
                                        blurRadius: 12,
                                        spreadRadius: -3,
                                        offset: const Offset(0, -4),
                                      ),
                                    ],
                                  )
                                  : BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFFE2E8F0),
                                        const Color(0xFFCBD5E1),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                          child: Icon(
                            Icons.search_rounded,
                            size: 30,
                            color:
                                _currentIndex == 2
                                    ? Colors.white
                                    : const Color(0xFF64748B),
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
                          padding: const EdgeInsets.all(10),
                          decoration:
                              _currentIndex == 3
                                  ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFF667EEA),
                                        const Color(0xFF764BA2),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF667EEA,
                                        ).withOpacity(0.4),
                                        blurRadius: 20,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 8),
                                      ),
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.9),
                                        blurRadius: 8,
                                        spreadRadius: -2,
                                        offset: const Offset(0, -2),
                                      ),
                                    ],
                                  )
                                  : BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                  ),
                          child: Icon(
                            Icons.analytics_rounded,
                            size: 26,
                            color:
                                _currentIndex == 3
                                    ? Colors.white
                                    : const Color(0xFF64748B),
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
                          padding: const EdgeInsets.all(10),
                          decoration:
                              _currentIndex == 4
                                  ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFF667EEA),
                                        const Color(0xFF764BA2),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF667EEA,
                                        ).withOpacity(0.4),
                                        blurRadius: 20,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 8),
                                      ),
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.9),
                                        blurRadius: 8,
                                        spreadRadius: -2,
                                        offset: const Offset(0, -2),
                                      ),
                                    ],
                                  )
                                  : BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                  ),
                          child: Icon(
                            Icons.person_rounded,
                            size: 26,
                            color:
                                _currentIndex == 4
                                    ? Colors.white
                                    : const Color(0xFF64748B),
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
