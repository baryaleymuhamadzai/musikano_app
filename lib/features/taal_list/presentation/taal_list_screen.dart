import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../core/widgets/search_bar.dart';
import '../../../providers/taal_provider.dart';
import '../../../providers/favourites_provider.dart';

class TaalListScreen extends ConsumerStatefulWidget {
  const TaalListScreen({super.key});

  @override
  ConsumerState<TaalListScreen> createState() => _TaalListScreenState();
}

class _TaalListScreenState extends ConsumerState<TaalListScreen> {
  int _selectedTabIndex = 0;
  String _searchQuery = '';
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final taals = ref.watch(allTaalsProvider);
    final filteredTaals = ref.watch(searchedTaalsProvider(_searchQuery));
    final favouriteIdsAsync = ref.watch(favouritesTaalIdsProvider);
    final favouriteIds = favouriteIdsAsync.maybeWhen(data: (ids) => ids, orElse: () => <String>[]);
    final displayedTaals = _selectedTabIndex == 0
        ? filteredTaals
        : filteredTaals.where((t) => favouriteIds.contains(t.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.music_note, size: 24),
            SizedBox(width: 8),
            Text(AppStrings.appName),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
            tooltip: AppStrings.settings,
          ),
        ],
      ),
      body: Column(
        children: [
          PremiumBanner(onGetPremiumPressed: () => context.push('/premium')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SectionTab(
              tabs: [
                '${AppStrings.allTab} (${taals.length})',
                '${AppStrings.favouritesTab} (${favouriteIds.length})',
              ],
              selectedIndex: _selectedTabIndex,
              onTabChanged: (i) => setState(() => _selectedTabIndex = i),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SearchBarWidget(
              hintText: AppStrings.search,
              controller: _searchController,
              onChanged: (q) => setState(() => _searchQuery = q),
            ),
          ),
          Expanded(
            child: _selectedTabIndex == 1 && displayedTaals.isEmpty
                ? EmptyState(icon: Icons.star_outline, message: AppStrings.noFavouritesText)
                : ListView.separated(
                    itemCount: displayedTaals.length,
                    separatorBuilder: (_, __) => Divider(color: colors.divider, height: 0),
                    itemBuilder: (_, i) {
                      final taal = displayedTaals[i];
                      final isFav = favouriteIds.contains(taal.id);
                      return ListTile(
                        title: Text(
                          '${taal.name} (${taal.beatCount} ${AppStrings.beats})',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          '${taal.variationCount} ${AppStrings.variations}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(isFav ? Icons.star : Icons.star_outline,
                                  color: isFav ? colors.primary : colors.textHint),
                              onPressed: () => ref.read(mutableFavouritesProvider.notifier).toggleFavourite(taal.id),
                              tooltip: 'Toggle favourite',
                            ),
                            Icon(Icons.chevron_right, color: colors.textHint),
                          ],
                        ),
                        onTap: () => context.push('/taal/${taal.id}'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
