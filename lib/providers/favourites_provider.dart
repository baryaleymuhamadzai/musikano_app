import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'repository_providers.dart';

part 'favourites_provider.g.dart';

@riverpod
Future<List<String>> favouritesTaalIds(FavouritesTaalIdsRef ref) async {
  final repo = await ref.watch(favouritesRepositoryProvider.future);
  return repo.getFavouriteIds();
}

@riverpod
class MutableFavourites extends _$MutableFavourites {
  @override
  Future<List<String>> build() async {
    return ref.watch(favouritesTaalIdsProvider.future);
  }

  Future<void> toggleFavourite(String taalId) async {
    final repo = await ref.read(favouritesRepositoryProvider.future);
    await repo.toggleFavourite(taalId);
    final updated = await repo.getFavouriteIds();
    state = AsyncData(updated);
  }

  bool isFavourite(String taalId) {
    return state.maybeWhen(data: (list) => list.contains(taalId), orElse: () => false);
  }
}
