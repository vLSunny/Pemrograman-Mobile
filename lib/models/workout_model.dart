class Workout {
  final String id;
  final String name;
  final String type;
  final int duration; // in minutes
  final int calories;
  final List<String> exercises;
  final String difficulty;
  final String? description;
  final DateTime scheduledDate;
  final bool isCompleted;
  final String? notes;

  Workout({
    required this.id,
    required this.name,
    required this.type,
    required this.duration,
    required this.calories,
    required this.exercises,
    required this.difficulty,
    this.description,
    required this.scheduledDate,
    this.isCompleted = false,
    this.notes,
  });

  Workout copyWith({
    String? id,
    String? name,
    String? type,
    int? duration,
    int? calories,
    List<String>? exercises,
    String? difficulty,
    String? description,
    DateTime? scheduledDate,
    bool? isCompleted,
    String? notes,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      calories: calories ?? this.calories,
      exercises: exercises ?? this.exercises,
      difficulty: difficulty ?? this.difficulty,
      description: description ?? this.description,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      isCompleted: isCompleted ?? this.isCompleted,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'duration': duration,
      'calories': calories,
      'exercises': exercises,
      'difficulty': difficulty,
      'description': description,
      'scheduledDate': scheduledDate.toIso8601String(),
      'isCompleted': isCompleted,
      'notes': notes,
    };
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      duration: json['duration'],
      calories: json['calories'],
      exercises: List<String>.from(json['exercises']),
      difficulty: json['difficulty'],
      description: json['description'],
      scheduledDate: DateTime.parse(json['scheduledDate']),
      isCompleted: json['isCompleted'] ?? false,
      notes: json['notes'],
    );
  }
}

class Exercise {
  final String name;
  final int sets;
  final int reps;
  final int duration; // in seconds
  final String? instructions;
  final String? videoUrl;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.duration,
    this.instructions,
    this.videoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
      'duration': duration,
      'instructions': instructions,
      'videoUrl': videoUrl,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      sets: json['sets'],
      reps: json['reps'],
      duration: json['duration'],
      instructions: json['instructions'],
      videoUrl: json['videoUrl'],
    );
  }
}
