// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favouritesTaalIdsHash() => r'9b06d7dbe97ed3fa1394a152d8294d17dae4ece0';

/// See also [favouritesTaalIds].
@ProviderFor(favouritesTaalIds)
final favouritesTaalIdsProvider =
    AutoDisposeFutureProvider<List<String>>.internal(
      favouritesTaalIds,
      name: r'favouritesTaalIdsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$favouritesTaalIdsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavouritesTaalIdsRef = AutoDisposeFutureProviderRef<List<String>>;
String _$mutableFavouritesHash() => r'd351d0d46b0745ae780db3a4a3269c393a0e2b6c';

/// See also [MutableFavourites].
@ProviderFor(MutableFavourites)
final mutableFavouritesProvider =
    AutoDisposeAsyncNotifierProvider<MutableFavourites, List<String>>.internal(
      MutableFavourites.new,
      name: r'mutableFavouritesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$mutableFavouritesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MutableFavourites = AutoDisposeAsyncNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
