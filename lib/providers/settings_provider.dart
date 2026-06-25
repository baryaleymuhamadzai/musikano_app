import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/app_settings.dart';
import 'repository_providers.dart';

part 'settings_provider.g.dart';

@riverpod
Future<AppSettings> appSettings(AppSettingsRef ref) async {
  final repo = await ref.watch(settingsRepositoryProvider.future);
  return repo.getSettings();
}

@riverpod
class MutableSettings extends _$MutableSettings {
  @override
  Future<AppSettings> build() async {
    return ref.watch(appSettingsProvider.future);
  }

  AppSettings _current() => state.maybeWhen(data: (s) => s, orElse: () => AppSettings.defaults);

  Future<void> _save(AppSettings s) async {
    final repo = await ref.read(settingsRepositoryProvider.future);
    await repo.updateSettings(s);
    state = AsyncData(s);
    // Invalidate so all other providers watching appSettingsProvider
    // (taal sort, wakelock, vibrate, beat progress) see the new value immediately.
    ref.invalidate(appSettingsProvider);
  }

  Future<void> updateThemeMode(String v) async => _save(_current().copyWith(themeMode: v));
  Future<void> updateVibrate(bool v) async => _save(_current().copyWith(vibrate: v));
  Future<void> updateSortByBeat(bool v) async => _save(_current().copyWith(sortByBeat: v));
  Future<void> updateAwakeScreen(bool v) async => _save(_current().copyWith(awakScreen: v));
  Future<void> updateBeatProgress(bool v) async => _save(_current().copyWith(beatProgress: v));
  Future<void> updateBeatCountDelay(bool v) async => _save(_current().copyWith(beatCountDelay: v));
  Future<void> updateBeatDelayMs(int v) async => _save(_current().copyWith(beatDelayMs: v));
}
