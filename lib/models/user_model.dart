class UserModel {
  final String id;
  final String email;
  final String password;
  final String name;
  final int age;
  final double height; // in cm
  final double weight; // in kg
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
    'name': name,
    'age': age,
    'height': height,
    'weight': weight,
    'createdAt': createdAt.toIso8601String(),
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    email: json['email'],
    password: json['password'],
    name: json['name'],
    age: json['age'],
    height: json['height'].toDouble(),
    weight: json['weight'].toDouble(),
    createdAt: DateTime.parse(json['createdAt']),
  );
}
