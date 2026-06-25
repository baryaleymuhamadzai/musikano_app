// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appSettingsHash() => r'0a9e1a0d239cbcd54f6e82008fea7407d5f00d24';

/// See also [appSettings].
@ProviderFor(appSettings)
final appSettingsProvider = AutoDisposeFutureProvider<AppSettings>.internal(
  appSettings,
  name: r'appSettingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppSettingsRef = AutoDisposeFutureProviderRef<AppSettings>;
String _$mutableSettingsHash() => r'db9907233aa410c100f71192623e2d2a0f2a3503';

/// See also [MutableSettings].
@ProviderFor(MutableSettings)
final mutableSettingsProvider =
    AutoDisposeAsyncNotifierProvider<MutableSettings, AppSettings>.internal(
      MutableSettings.new,
      name: r'mutableSettingsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$mutableSettingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MutableSettings = AutoDisposeAsyncNotifier<AppSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
