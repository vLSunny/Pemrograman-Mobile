import 'dart:async';
import 'package:fitnestx/models/workout_model.dart';

class WorkoutService {
  static final List<Workout> _workouts = [
    Workout(
      id: '1',
      name: 'Morning Cardio',
      type: 'Cardio',
      duration: 30,
      calories: 250,
      exercises: ['Running', 'Jumping Jacks', 'Burpees'],
      difficulty: 'Beginner',
      description: 'Energizing morning cardio routine',
      scheduledDate: DateTime.now().subtract(Duration(days: 1)),
      isCompleted: true,
    ),
    Workout(
      id: '2',
      name: 'Strength Training',
      type: 'Strength',
      duration: 45,
      calories: 320,
      exercises: ['Push-ups', 'Squats', 'Lunges', 'Plank'],
      difficulty: 'Intermediate',
      description: 'Full body strength workout',
      scheduledDate: DateTime.now(),
      isCompleted: false,
    ),
    Workout(
      id: '3',
      name: 'Yoga Flow',
      type: 'Yoga',
      duration: 60,
      calories: 180,
      exercises: ['Sun Salutation', 'Warrior Pose', 'Tree Pose'],
      difficulty: 'Beginner',
      description: 'Relaxing yoga flow for flexibility',
      scheduledDate: DateTime.now().add(Duration(days: 1)),
      isCompleted: false,
    ),
    Workout(
      id: '4',
      name: 'HIIT Challenge',
      type: 'HIIT',
      duration: 20,
      calories: 400,
      exercises: ['Mountain Climbers', 'Jump Squats', 'Push-ups'],
      difficulty: 'Advanced',
      description: 'High intensity interval training',
      scheduledDate: DateTime.now().add(Duration(days: 2)),
      isCompleted: false,
    ),
  ];
  static final StreamController<List<Workout>> _workoutController =
      StreamController<List<Workout>>.broadcast();

  static Stream<List<Workout>> get workoutUpdates => _workoutController.stream;

  static List<Workout> getAllWorkouts() => List.from(_workouts);

  static List<Workout> getWorkoutsForDate(DateTime date) {
    return _workouts.where((workout) {
      return workout.scheduledDate.year == date.year &&
          workout.scheduledDate.month == date.month &&
          workout.scheduledDate.day == date.day;
    }).toList();
  }

  static List<Workout> getUpcomingWorkouts() {
    final now = DateTime.now();
    return _workouts
        .where(
          (workout) =>
              workout.scheduledDate.isAfter(now) && !workout.isCompleted,
        )
        .toList()
      ..sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));
  }

  static List<Workout> getCompletedWorkouts() {
    return _workouts.where((workout) => workout.isCompleted).toList()
      ..sort((a, b) => b.scheduledDate.compareTo(a.scheduledDate));
  }

  static void addWorkout(Workout workout) {
    _workouts.add(workout);
    _workoutController.add(List.from(_workouts));
  }

  static void updateWorkout(Workout updatedWorkout) {
    final index = _workouts.indexWhere((w) => w.id == updatedWorkout.id);
    if (index != -1) {
      _workouts[index] = updatedWorkout;
      _workoutController.add(List.from(_workouts));
    }
  }

  static void deleteWorkout(String id) {
    _workouts.removeWhere((workout) => workout.id == id);
    _workoutController.add(List.from(_workouts));
  }

  static void toggleWorkoutCompletion(String id) {
    final index = _workouts.indexWhere((w) => w.id == id);
    if (index != -1) {
      final workout = _workouts[index];
      _workouts[index] = workout.copyWith(isCompleted: !workout.isCompleted);
      _workoutController.add(List.from(_workouts));
    }
  }

  static List<Workout> getWorkoutsByType(String type) {
    return _workouts.where((workout) => workout.type == type).toList();
  }

  static Map<String, int> getWorkoutStats() {
    final stats = <String, int>{
      'total': _workouts.length,
      'completed': _workouts.where((w) => w.isCompleted).length,
      'pending':
          _workouts
              .where(
                (w) =>
                    !w.isCompleted && w.scheduledDate.isAfter(DateTime.now()),
              )
              .length,
      'missed':
          _workouts
              .where(
                (w) =>
                    !w.isCompleted && w.scheduledDate.isBefore(DateTime.now()),
              )
              .length,
    };
    return stats;
  }

  static List<Workout> getWorkoutTemplates() {
    return [
      Workout(
        id: 'template_1',
        name: 'Morning Cardio Blast',
        type: 'Cardio',
        duration: 30,
        calories: 250,
        exercises: [
          'Jumping Jacks',
          'High Knees',
          'Burpees',
          'Mountain Climbers',
        ],
        difficulty: 'Beginner',
        description: 'Quick morning cardio to boost metabolism',
        scheduledDate: DateTime.now(),
      ),
      Workout(
        id: 'template_2',
        name: 'Strength Training',
        type: 'Strength',
        duration: 45,
        calories: 300,
        exercises: ['Push-ups', 'Squats', 'Lunges', 'Plank'],
        difficulty: 'Intermediate',
        description: 'Full body strength workout',
        scheduledDate: DateTime.now(),
      ),
      Workout(
        id: 'template_3',
        name: 'Yoga Flow',
        type: 'Yoga',
        duration: 60,
        calories: 200,
        exercises: [
          'Sun Salutation',
          'Warrior Pose',
          'Tree Pose',
          'Child Pose',
        ],
        difficulty: 'Beginner',
        description: 'Relaxing yoga flow for flexibility',
        scheduledDate: DateTime.now(),
      ),
      Workout(
        id: 'template_4',
        name: 'HIIT Challenge',
        type: 'HIIT',
        duration: 20,
        calories: 400,
        exercises: ['Sprint', 'Jump Squats', 'Push-ups', 'Plank Jacks'],
        difficulty: 'Advanced',
        description: 'High intensity interval training',
        scheduledDate: DateTime.now(),
      ),
    ];
  }

  static void dispose() {
    _workoutController.close();
  }
}
