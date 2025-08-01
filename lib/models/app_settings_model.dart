class AppSettingsModel {
  final bool darkMode;
  final String language;
  final bool notificationsEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final String themeColor;
  final String measurementUnit; // 'metric' or 'imperial'
  final bool autoBackup;
  final DateTime? lastBackupDate;

  AppSettingsModel({
    this.darkMode = false,
    this.language = 'en',
    this.notificationsEnabled = true,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.themeColor = 'blue',
    this.measurementUnit = 'metric',
    this.autoBackup = false,
    this.lastBackupDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'darkMode': darkMode,
      'language': language,
      'notificationsEnabled': notificationsEnabled,
      'soundEnabled': soundEnabled,
      'vibrationEnabled': vibrationEnabled,
      'themeColor': themeColor,
      'measurementUnit': measurementUnit,
      'autoBackup': autoBackup,
      'lastBackupDate': lastBackupDate?.toIso8601String(),
    };
  }

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      darkMode: json['darkMode'] ?? false,
      language: json['language'] ?? 'en',
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      soundEnabled: json['soundEnabled'] ?? true,
      vibrationEnabled: json['vibrationEnabled'] ?? true,
      themeColor: json['themeColor'] ?? 'blue',
      measurementUnit: json['measurementUnit'] ?? 'metric',
      autoBackup: json['autoBackup'] ?? false,
      lastBackupDate:
          json['lastBackupDate'] != null
              ? DateTime.parse(json['lastBackupDate'])
              : null,
    );
  }

  AppSettingsModel copyWith({
    bool? darkMode,
    String? language,
    bool? notificationsEnabled,
    bool? soundEnabled,
    bool? vibrationEnabled,
    String? themeColor,
    String? measurementUnit,
    bool? autoBackup,
    DateTime? lastBackupDate,
  }) {
    return AppSettingsModel(
      darkMode: darkMode ?? this.darkMode,
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      themeColor: themeColor ?? this.themeColor,
      measurementUnit: measurementUnit ?? this.measurementUnit,
      autoBackup: autoBackup ?? this.autoBackup,
      lastBackupDate: lastBackupDate ?? this.lastBackupDate,
    );
  }
}
