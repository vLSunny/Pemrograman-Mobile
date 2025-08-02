import 'package:flutter/material.dart';
import 'package:fitnestx/services/workout_service.dart';

class WorkoutScheduleWidget extends StatefulWidget {
  const WorkoutScheduleWidget({super.key});

  @override
  State<WorkoutScheduleWidget> createState() => _WorkoutScheduleWidgetState();
}

class _WorkoutScheduleWidgetState extends State<WorkoutScheduleWidget> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  void _loadWorkouts() {
    setState(() {
      WorkoutService.getWorkoutsForDate(_selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Workout Schedule'));
  }
}
