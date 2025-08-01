class WaterIntakeModel {
  final String id;
  final double amount; // in milliliters
  final DateTime timestamp;
  final String? note;

  WaterIntakeModel({
    required this.id,
    required this.amount,
    required this.timestamp,
    this.note,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
    'timestamp': timestamp.toIso8601String(),
    'note': note,
  };

  factory WaterIntakeModel.fromJson(Map<String, dynamic> json) =>
      WaterIntakeModel(
        id: json['id'],
        amount: json['amount'].toDouble(),
        timestamp: DateTime.parse(json['timestamp']),
        note: json['note'],
      );

  WaterIntakeModel copyWith({
    String? id,
    double? amount,
    DateTime? timestamp,
    String? note,
  }) {
    return WaterIntakeModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      timestamp: timestamp ?? this.timestamp,
      note: note ?? this.note,
    );
  }
}
