class NotificationSettings {
  final bool masterEnabled;
  final bool quietHoursEnabled;
  final String quietHoursStart;
  final String quietHoursEnd;
  final bool soundEnabled;      // ← add
  final bool vibrationEnabled;  // ← add

  NotificationSettings({
    this.masterEnabled = true,
    this.quietHoursEnabled = false,
    this.quietHoursStart = '11:00 PM',
    this.quietHoursEnd = '7:00 AM',
    this.soundEnabled = true,
    this.vibrationEnabled = true,
  });

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      NotificationSettings(
        masterEnabled: json['masterEnabled'] ?? true,
        quietHoursEnabled: json['quietHoursEnabled'] ?? false,
        quietHoursStart: json['quietHoursStart'] ?? '11:00 PM',
        quietHoursEnd: json['quietHoursEnd'] ?? '7:00 AM',
        soundEnabled: json['soundEnabled'] ?? true,
        vibrationEnabled: json['vibrationEnabled'] ?? true,
      );

  Map<String, dynamic> toJson() => {
    'masterEnabled': masterEnabled,
    'quietHoursEnabled': quietHoursEnabled,
    'quietHoursStart': quietHoursStart,
    'quietHoursEnd': quietHoursEnd,
    'soundEnabled': soundEnabled,
    'vibrationEnabled': vibrationEnabled,
  };

  NotificationSettings copyWith({
    bool? masterEnabled,
    bool? quietHoursEnabled,
    String? quietHoursStart,
    String? quietHoursEnd,
    bool? soundEnabled,
    bool? vibrationEnabled,
  }) => NotificationSettings(
    masterEnabled: masterEnabled ?? this.masterEnabled,
    quietHoursEnabled: quietHoursEnabled ?? this.quietHoursEnabled,
    quietHoursStart: quietHoursStart ?? this.quietHoursStart,
    quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
    soundEnabled: soundEnabled ?? this.soundEnabled,
    vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
  );
}