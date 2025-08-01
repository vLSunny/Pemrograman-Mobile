class UserProfileModel {
  final String id;
  final String email;
  final String password;
  final String name;
  final int age;
  final double height; // in cm
  final double weight; // in kg
  final DateTime dateOfBirth;
  final String gender;
  final String healthInfo;
  final String phone;
  final DateTime createdAt;

  UserProfileModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.dateOfBirth,
    required this.gender,
    required this.healthInfo,
    required this.phone,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Calculate BMI
  double get bmi {
    if (height <= 0) return 0;
    return weight / ((height / 100) * (height / 100));
  }

  // Get BMI category
  String get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue < 18.5) return 'Underweight';
    if (bmiValue < 25) return 'Normal';
    if (bmiValue < 30) return 'Overweight';
    return 'Obese';
  }

  // Calculate age from date of birth
  static int calculateAge(DateTime dateOfBirth) {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
    'name': name,
    'age': age,
    'height': height,
    'weight': weight,
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'gender': gender,
    'healthInfo': healthInfo,
    'phone': phone,
    'createdAt': createdAt.toIso8601String(),
  };

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json['id'],
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        name: json['name'],
        age: json['age'],
        height: json['height'].toDouble(),
        weight: json['weight'].toDouble(),
        dateOfBirth: DateTime.parse(json['dateOfBirth']),
        gender: json['gender'] ?? '',
        healthInfo: json['healthInfo'] ?? '',
        phone: json['phone'] ?? '',
        createdAt: DateTime.parse(json['createdAt']),
      );
}
