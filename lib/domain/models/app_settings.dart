class AppSettings {
  const AppSettings({
    required this.themeMode,
    required this.vibrate,
    required this.sortByBeat,
    required this.awakScreen,
    required this.beatProgress,
    required this.beatCountDelay,
    required this.beatDelayMs,
  });

  final String themeMode;
  final bool vibrate;
  final bool sortByBeat;
  final bool awakScreen;
  final bool beatProgress;
  final bool beatCountDelay;
  final int beatDelayMs;

  static const defaults = AppSettings(
    themeMode: 'system',
    vibrate: false,
    sortByBeat: false,
    awakScreen: true,
    beatProgress: true,
    beatCountDelay: false,
    beatDelayMs: 0,
  );

  AppSettings copyWith({
    String? themeMode,
    bool? vibrate,
    bool? sortByBeat,
    bool? awakScreen,
    bool? beatProgress,
    bool? beatCountDelay,
    int? beatDelayMs,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      vibrate: vibrate ?? this.vibrate,
      sortByBeat: sortByBeat ?? this.sortByBeat,
      awakScreen: awakScreen ?? this.awakScreen,
      beatProgress: beatProgress ?? this.beatProgress,
      beatCountDelay: beatCountDelay ?? this.beatCountDelay,
      beatDelayMs: beatDelayMs ?? this.beatDelayMs,
    );
  }
}
