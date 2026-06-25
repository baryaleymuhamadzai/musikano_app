import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repositories/taal_repository_impl.dart';
import '../data/repositories/settings_repository_impl.dart';
import '../data/repositories/favourites_repository_impl.dart';
import '../domain/repositories/taal_repository.dart';
import '../domain/repositories/settings_repository.dart';
import '../domain/repositories/favourites_repository.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

final taalRepositoryProvider = Provider<TaalRepository>((ref) {
  return TaalRepositoryImpl();
});

final settingsRepositoryProvider = FutureProvider<SettingsRepository>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return SettingsRepositoryImpl(prefs);
});

final favouritesRepositoryProvider = FutureProvider<FavouritesRepository>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return FavouritesRepositoryImpl(prefs);
});
