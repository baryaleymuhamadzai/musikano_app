import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._prefs);
  final SharedPreferences _prefs;

  @override
  Future<AppSettings> getSettings() async {
    return AppSettings(
      themeMode: _prefs.getString('themeMode') ?? 'system',
      vibrate: _prefs.getBool('vibrate') ?? false,
      sortByBeat: _prefs.getBool('sortByBeat') ?? false,
      awakScreen: _prefs.getBool('awakScreen') ?? true,
      beatProgress: _prefs.getBool('beatProgress') ?? true,
      beatCountDelay: _prefs.getBool('beatCountDelay') ?? false,
      beatDelayMs: _prefs.getInt('beatDelayMs') ?? 0,
    );
  }

  @override
  Future<void> updateSettings(AppSettings settings) async {
    await _prefs.setString('themeMode', settings.themeMode);
    await _prefs.setBool('vibrate', settings.vibrate);
    await _prefs.setBool('sortByBeat', settings.sortByBeat);
    await _prefs.setBool('awakScreen', settings.awakScreen);
    await _prefs.setBool('beatProgress', settings.beatProgress);
    await _prefs.setBool('beatCountDelay', settings.beatCountDelay);
    await _prefs.setInt('beatDelayMs', settings.beatDelayMs);
  }
}
