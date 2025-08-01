import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fitnestx/models/workout_model.dart';
import 'package:fitnestx/services/workout_service.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutScheduleTab extends StatefulWidget {
  const WorkoutScheduleTab({super.key});

  @override
  State<WorkoutScheduleTab> createState() => _WorkoutScheduleTabState();
}

class _WorkoutScheduleTabState extends State<WorkoutScheduleTab> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<Workout> _selectedWorkouts = [];
  final Map<DateTime, List<Workout>> _workouts = {};

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
    WorkoutService.workoutUpdates.listen((_) {
      if (mounted) {
        _loadWorkouts();
      }
    });
  }

  void _loadWorkouts() {
    setState(() {
      _workouts.clear();
      final allWorkouts = WorkoutService.getAllWorkouts();
      for (var workout in allWorkouts) {
        final date = DateTime(
          workout.scheduledDate.year,
          workout.scheduledDate.month,
          workout.scheduledDate.day,
        );
        if (_workouts[date] == null) {
          _workouts[date] = [];
        }
        _workouts[date]!.add(workout);
      }
      _selectedWorkouts = _getWorkoutsForDay(_selectedDay);
    });
  }

  List<Workout> _getWorkoutsForDay(DateTime day) {
    return _workouts[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedWorkouts = _getWorkoutsForDay(selectedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          _buildCalendar(),
          _buildStatsCards(),
          Expanded(child: _buildWorkoutList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddWorkoutDialog,
        backgroundColor: Colors.blue[600],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TableCalendar<Workout>(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        eventLoader: _getWorkoutsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendTextStyle: TextStyle(color: Colors.red),
          holidayTextStyle: TextStyle(color: Colors.red),
          selectedDecoration: BoxDecoration(
            color: Colors.blue[600],
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.blue[200],
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonShowsNext: false,
          formatButtonDecoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          formatButtonTextStyle: TextStyle(color: Colors.blue[600]),
        ),
        onDaySelected: _onDaySelected,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }

  Widget _buildStatsCards() {
    final stats = WorkoutService.getWorkoutStats();

    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildStatCard('Total', stats['total'] ?? 0, Colors.blue),
          SizedBox(width: 12),
          _buildStatCard('Completed', stats['completed'] ?? 0, Colors.green),
          SizedBox(width: 12),
          _buildStatCard('Pending', stats['pending'] ?? 0, Colors.orange),
          SizedBox(width: 12),
          _buildStatCard('Missed', stats['missed'] ?? 0, Colors.red),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int value, Color color) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value.toString(),
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutList() {
    if (_selectedWorkouts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 64, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              'No workouts scheduled',
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Tap + to add a workout',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[400]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _selectedWorkouts.length,
      itemBuilder: (context, index) {
        final workout = _selectedWorkouts[index];
        return _buildWorkoutCard(workout);
      },
    );
  }

  Widget _buildWorkoutCard(Workout workout) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getWorkoutTypeColor(workout.type),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getWorkoutIcon(workout.type),
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          workout.name,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              '${workout.duration} min • ${workout.calories} cal',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
            Text(
              workout.difficulty,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: _getDifficultyColor(workout.difficulty),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                workout.isCompleted
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: workout.isCompleted ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                WorkoutService.toggleWorkoutCompletion(workout.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _showEditWorkoutDialog(workout),
            ),
          ],
        ),
        onTap: () => _showWorkoutDetails(workout),
      ),
    );
  }

  Color _getWorkoutTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'cardio':
        return Colors.red;
      case 'strength':
        return Colors.blue;
      case 'yoga':
        return Colors.purple;
      case 'hiit':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getWorkoutIcon(String type) {
    switch (type.toLowerCase()) {
      case 'cardio':
        return Icons.directions_run;
      case 'strength':
        return Icons.fitness_center;
      case 'yoga':
        return Icons.self_improvement;
      case 'hiit':
        return Icons.bolt;
      default:
        return Icons.fitness_center;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddWorkoutDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AddWorkoutDialog(
            selectedDate: _selectedDay,
            onSave: (workout) {
              WorkoutService.addWorkout(workout);
            },
          ),
    );
  }

  void _showEditWorkoutDialog(Workout workout) {
    showDialog(
      context: context,
      builder:
          (context) => AddWorkoutDialog(
            selectedDate: _selectedDay,
            workout: workout,
            onSave: (updatedWorkout) {
              WorkoutService.updateWorkout(updatedWorkout);
            },
          ),
    );
  }

  void _showWorkoutDetails(Workout workout) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return WorkoutDetailsModal(workout: workout);
      },
    );
  }
}

class AddWorkoutDialog extends StatefulWidget {
  final DateTime selectedDate;
  final Function(Workout) onSave;
  final Workout? workout;

  const AddWorkoutDialog({
    super.key,
    required this.selectedDate,
    required this.onSave,
    this.workout,
  });

  @override
  State<AddWorkoutDialog> createState() => _AddWorkoutDialogState();
}

class _AddWorkoutDialogState extends State<AddWorkoutDialog> {
  late TextEditingController _nameController;
  late TextEditingController _durationController;
  late TextEditingController _caloriesController;
  late TextEditingController _descriptionController;
  String _selectedType = 'Cardio';
  String _selectedDifficulty = 'Beginner';
  DateTime _selectedDate = DateTime.now();

  final List<String> _workoutTypes = [
    'Cardio',
    'Strength',
    'Yoga',
    'HIIT',
    'Flexibility',
  ];
  final List<String> _difficulties = ['Beginner', 'Intermediate', 'Advanced'];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.workout?.scheduledDate ?? widget.selectedDate;
    _nameController = TextEditingController(text: widget.workout?.name ?? '');
    _durationController = TextEditingController(
      text: widget.workout?.duration.toString() ?? '30',
    );
    _caloriesController = TextEditingController(
      text: widget.workout?.calories.toString() ?? '200',
    );
    _descriptionController = TextEditingController(
      text: widget.workout?.description ?? '',
    );
    _selectedType = widget.workout?.type ?? 'Cardio';
    _selectedDifficulty = widget.workout?.difficulty ?? 'Beginner';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _caloriesController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.workout == null ? 'Add Workout' : 'Edit Workout',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Workout Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: InputDecoration(
                  labelText: 'Workout Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items:
                    _workoutTypes.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDifficulty,
                decoration: InputDecoration(
                  labelText: 'Difficulty',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items:
                    _difficulties.map((difficulty) {
                      return DropdownMenuItem(
                        value: difficulty,
                        child: Text(difficulty),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDifficulty = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _durationController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Duration (min)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _caloriesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Calories',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _saveWorkout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveWorkout() {
    if (_nameController.text.isEmpty) return;

    final workout = Workout(
      id:
          widget.workout?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      type: _selectedType,
      duration: int.tryParse(_durationController.text) ?? 30,
      calories: int.tryParse(_caloriesController.text) ?? 200,
      exercises: [],
      difficulty: _selectedDifficulty,
      description: _descriptionController.text,
      scheduledDate: _selectedDate,
    );

    widget.onSave(workout);
    Navigator.pop(context);
  }
}

class WorkoutDetailsModal extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailsModal({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.fitness_center,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workout.name,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${workout.duration} min • ${workout.calories} cal',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Type', workout.type),
                  _buildDetailRow('Difficulty', workout.difficulty),
                  _buildDetailRow(
                    'Date',
                    '${workout.scheduledDate.day}/${workout.scheduledDate.month}/${workout.scheduledDate.year}',
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    workout.description ?? 'No description provided',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  if (workout.isCompleted)
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            'Completed',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
