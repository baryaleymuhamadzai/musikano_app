import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'providers/settings_provider.dart';

class MusikanoApp extends ConsumerWidget {
  const MusikanoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(appSettingsProvider);
    final themeMode = settingsAsync.maybeWhen(
      data: (s) {
        switch (s.themeMode) {
          case 'light': return ThemeMode.light;
          case 'dark': return ThemeMode.dark;
          default: return ThemeMode.system;
        }
      },
      orElse: () => ThemeMode.system,
    );

    return MaterialApp.router(
      title: 'Musikano',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeMode,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
