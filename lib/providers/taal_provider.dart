import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/taal.dart';
import 'repository_providers.dart';
import 'settings_provider.dart';

part 'taal_provider.g.dart';

@riverpod
List<Taal> allTaals(AllTaalsRef ref) {
  final settingsAsync = ref.watch(appSettingsProvider);
  final sortByBeat = settingsAsync.maybeWhen(data: (s) => s.sortByBeat, orElse: () => false);
  final taals = ref.watch(taalRepositoryProvider).getAllTaals();
  if (sortByBeat) {
    return [...taals]..sort((a, b) => a.beatCount.compareTo(b.beatCount));
  }
  return taals;
}

@riverpod
class SearchedTaals extends _$SearchedTaals {
  @override
  List<Taal> build(String query) {
    final allTaals = ref.watch(allTaalsProvider);
    if (query.isEmpty) return allTaals;
    return allTaals
        .where((t) => t.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
