import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/favourites_repository.dart';

class FavouritesRepositoryImpl implements FavouritesRepository {
  FavouritesRepositoryImpl(this._prefs);
  final SharedPreferences _prefs;

  @override
  Future<List<String>> getFavouriteIds() async {
    return _prefs.getStringList('favourites') ?? [];
  }

  @override
  Future<void> toggleFavourite(String taalId) async {
    final current = await getFavouriteIds();
    final updated = current.contains(taalId)
        ? current.where((id) => id != taalId).toList()
        : [...current, taalId];
    await _prefs.setStringList('favourites', updated);
  }

  @override
  Future<bool> isFavourite(String taalId) async {
    final ids = await getFavouriteIds();
    return ids.contains(taalId);
  }
}
