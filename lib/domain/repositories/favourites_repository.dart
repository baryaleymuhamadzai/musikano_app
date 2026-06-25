abstract class FavouritesRepository {
  Future<List<String>> getFavouriteIds();
  Future<void> toggleFavourite(String taalId);
  Future<bool> isFavourite(String taalId);
}
