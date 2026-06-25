// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allTaalsHash() => r'aeb51e70a6ba0c3feae49a9faaedf40e4657c0c8';

/// See also [allTaals].
@ProviderFor(allTaals)
final allTaalsProvider = AutoDisposeProvider<List<Taal>>.internal(
  allTaals,
  name: r'allTaalsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allTaalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllTaalsRef = AutoDisposeProviderRef<List<Taal>>;
String _$searchedTaalsHash() => r'fe50656ea7456523804b309741c7c3d241f97a7f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SearchedTaals
    extends BuildlessAutoDisposeNotifier<List<Taal>> {
  late final String query;

  List<Taal> build(String query);
}

/// See also [SearchedTaals].
@ProviderFor(SearchedTaals)
const searchedTaalsProvider = SearchedTaalsFamily();

/// See also [SearchedTaals].
class SearchedTaalsFamily extends Family<List<Taal>> {
  /// See also [SearchedTaals].
  const SearchedTaalsFamily();

  /// See also [SearchedTaals].
  SearchedTaalsProvider call(String query) {
    return SearchedTaalsProvider(query);
  }

  @override
  SearchedTaalsProvider getProviderOverride(
    covariant SearchedTaalsProvider provider,
  ) {
    return call(provider.query);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchedTaalsProvider';
}

/// See also [SearchedTaals].
class SearchedTaalsProvider
    extends AutoDisposeNotifierProviderImpl<SearchedTaals, List<Taal>> {
  /// See also [SearchedTaals].
  SearchedTaalsProvider(String query)
    : this._internal(
        () => SearchedTaals()..query = query,
        from: searchedTaalsProvider,
        name: r'searchedTaalsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$searchedTaalsHash,
        dependencies: SearchedTaalsFamily._dependencies,
        allTransitiveDependencies:
            SearchedTaalsFamily._allTransitiveDependencies,
        query: query,
      );

  SearchedTaalsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  List<Taal> runNotifierBuild(covariant SearchedTaals notifier) {
    return notifier.build(query);
  }

  @override
  Override overrideWith(SearchedTaals Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchedTaalsProvider._internal(
        () => create()..query = query,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SearchedTaals, List<Taal>>
  createElement() {
    return _SearchedTaalsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchedTaalsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchedTaalsRef on AutoDisposeNotifierProviderRef<List<Taal>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchedTaalsProviderElement
    extends AutoDisposeNotifierProviderElement<SearchedTaals, List<Taal>>
    with SearchedTaalsRef {
  _SearchedTaalsProviderElement(super.provider);

  @override
  String get query => (origin as SearchedTaalsProvider).query;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
