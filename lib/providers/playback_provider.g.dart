// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedScaleHash() => r'30af51a4b0b0315b9e7af799e8f9b2f231a7c46a';

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

abstract class _$SelectedScale extends BuildlessAutoDisposeNotifier<String> {
  late final String taalId;

  String build(String taalId);
}

/// See also [SelectedScale].
@ProviderFor(SelectedScale)
const selectedScaleProvider = SelectedScaleFamily();

/// See also [SelectedScale].
class SelectedScaleFamily extends Family<String> {
  /// See also [SelectedScale].
  const SelectedScaleFamily();

  /// See also [SelectedScale].
  SelectedScaleProvider call(String taalId) {
    return SelectedScaleProvider(taalId);
  }

  @override
  SelectedScaleProvider getProviderOverride(
    covariant SelectedScaleProvider provider,
  ) {
    return call(provider.taalId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectedScaleProvider';
}

/// See also [SelectedScale].
class SelectedScaleProvider
    extends AutoDisposeNotifierProviderImpl<SelectedScale, String> {
  /// See also [SelectedScale].
  SelectedScaleProvider(String taalId)
    : this._internal(
        () => SelectedScale()..taalId = taalId,
        from: selectedScaleProvider,
        name: r'selectedScaleProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$selectedScaleHash,
        dependencies: SelectedScaleFamily._dependencies,
        allTransitiveDependencies:
            SelectedScaleFamily._allTransitiveDependencies,
        taalId: taalId,
      );

  SelectedScaleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taalId,
  }) : super.internal();

  final String taalId;

  @override
  String runNotifierBuild(covariant SelectedScale notifier) {
    return notifier.build(taalId);
  }

  @override
  Override overrideWith(SelectedScale Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectedScaleProvider._internal(
        () => create()..taalId = taalId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taalId: taalId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SelectedScale, String> createElement() {
    return _SelectedScaleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedScaleProvider && other.taalId == taalId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taalId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SelectedScaleRef on AutoDisposeNotifierProviderRef<String> {
  /// The parameter `taalId` of this provider.
  String get taalId;
}

class _SelectedScaleProviderElement
    extends AutoDisposeNotifierProviderElement<SelectedScale, String>
    with SelectedScaleRef {
  _SelectedScaleProviderElement(super.provider);

  @override
  String get taalId => (origin as SelectedScaleProvider).taalId;
}

String _$instrumentConfigNotifierHash() =>
    r'bcfc07945176bee164f40118ad846a8b6e8c2a0c';

abstract class _$InstrumentConfigNotifier
    extends BuildlessAutoDisposeNotifier<InstrumentConfig> {
  late final String taalId;
  late final String instrumentId;

  InstrumentConfig build(String taalId, String instrumentId);
}

/// See also [InstrumentConfigNotifier].
@ProviderFor(InstrumentConfigNotifier)
const instrumentConfigNotifierProvider = InstrumentConfigNotifierFamily();

/// See also [InstrumentConfigNotifier].
class InstrumentConfigNotifierFamily extends Family<InstrumentConfig> {
  /// See also [InstrumentConfigNotifier].
  const InstrumentConfigNotifierFamily();

  /// See also [InstrumentConfigNotifier].
  InstrumentConfigNotifierProvider call(String taalId, String instrumentId) {
    return InstrumentConfigNotifierProvider(taalId, instrumentId);
  }

  @override
  InstrumentConfigNotifierProvider getProviderOverride(
    covariant InstrumentConfigNotifierProvider provider,
  ) {
    return call(provider.taalId, provider.instrumentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'instrumentConfigNotifierProvider';
}

/// See also [InstrumentConfigNotifier].
class InstrumentConfigNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<
          InstrumentConfigNotifier,
          InstrumentConfig
        > {
  /// See also [InstrumentConfigNotifier].
  InstrumentConfigNotifierProvider(String taalId, String instrumentId)
    : this._internal(
        () =>
            InstrumentConfigNotifier()
              ..taalId = taalId
              ..instrumentId = instrumentId,
        from: instrumentConfigNotifierProvider,
        name: r'instrumentConfigNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$instrumentConfigNotifierHash,
        dependencies: InstrumentConfigNotifierFamily._dependencies,
        allTransitiveDependencies:
            InstrumentConfigNotifierFamily._allTransitiveDependencies,
        taalId: taalId,
        instrumentId: instrumentId,
      );

  InstrumentConfigNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taalId,
    required this.instrumentId,
  }) : super.internal();

  final String taalId;
  final String instrumentId;

  @override
  InstrumentConfig runNotifierBuild(
    covariant InstrumentConfigNotifier notifier,
  ) {
    return notifier.build(taalId, instrumentId);
  }

  @override
  Override overrideWith(InstrumentConfigNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: InstrumentConfigNotifierProvider._internal(
        () =>
            create()
              ..taalId = taalId
              ..instrumentId = instrumentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taalId: taalId,
        instrumentId: instrumentId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<InstrumentConfigNotifier, InstrumentConfig>
  createElement() {
    return _InstrumentConfigNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InstrumentConfigNotifierProvider &&
        other.taalId == taalId &&
        other.instrumentId == instrumentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taalId.hashCode);
    hash = _SystemHash.combine(hash, instrumentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InstrumentConfigNotifierRef
    on AutoDisposeNotifierProviderRef<InstrumentConfig> {
  /// The parameter `taalId` of this provider.
  String get taalId;

  /// The parameter `instrumentId` of this provider.
  String get instrumentId;
}

class _InstrumentConfigNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          InstrumentConfigNotifier,
          InstrumentConfig
        >
    with InstrumentConfigNotifierRef {
  _InstrumentConfigNotifierProviderElement(super.provider);

  @override
  String get taalId => (origin as InstrumentConfigNotifierProvider).taalId;
  @override
  String get instrumentId =>
      (origin as InstrumentConfigNotifierProvider).instrumentId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
