class UserModel {
  final String id;
  final String name;
  final int age;
  final double height; // in cm
  final double weight; // in kg
  final String gender; // 'Pria' or 'Wanita'
  final String activityLevel; // 'Rendah', 'Sedang', 'Tinggi'
  final String
  fitnessGoal; // 'Menurunkan Berat Badan', 'Menambah Berat Badan', 'Mempertahankan Berat Badan', 'Membangun Otot'
  final DateTime registrationDate;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.activityLevel,
    required this.fitnessGoal,
    DateTime? registrationDate,
  }) : registrationDate = registrationDate ?? DateTime.now();

  // Calculate BMI
  double get bmi {
    if (height <= 0) return 0;
    return weight / ((height / 100) * (height / 100));
  }

  // Get BMI category
  String get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue < 18.5) return 'Kurus';
    if (bmiValue < 25) return 'Normal';
    if (bmiValue < 30) return 'Gemuk';
    return 'Obesitas';
  }

  // Calculate daily calorie needs (Harris-Benedict Formula)
  double get dailyCalorieNeeds {
    double bmr;

    // Calculate BMR based on gender
    if (gender == 'Pria') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }

    // Apply activity factor
    double activityFactor;
    switch (activityLevel) {
      case 'Rendah':
        activityFactor = 1.2;
        break;
      case 'Sedang':
        activityFactor = 1.55;
        break;
      case 'Tinggi':
        activityFactor = 1.9;
        break;
      default:
        activityFactor = 1.55;
    }

    return bmr * activityFactor;
  }

  // Calculate ideal weight range (using BMI 18.5-24.9)
  Map<String, double> get idealWeightRange {
    final heightInM = height / 100;
    return {
      'min': 18.5 * heightInM * heightInM,
      'max': 24.9 * heightInM * heightInM,
    };
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
    'height': height,
    'weight': weight,
    'gender': gender,
    'activityLevel': activityLevel,
    'fitnessGoal': fitnessGoal,
    'registrationDate': registrationDate.toIso8601String(),
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    age: json['age'],
    height: json['height'].toDouble(),
    weight: json['weight'].toDouble(),
    gender: json['gender'],
    activityLevel: json['activityLevel'],
    fitnessGoal: json['fitnessGoal'],
    registrationDate: DateTime.parse(json['registrationDate']),
  );

  UserModel copyWith({
    String? id,
    String? name,
    int? age,
    double? height,
    double? weight,
    String? gender,
    String? activityLevel,
    String? fitnessGoal,
    DateTime? registrationDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      activityLevel: activityLevel ?? this.activityLevel,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      registrationDate: registrationDate ?? this.registrationDate,
    );
  }
}
