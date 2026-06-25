import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/settings_provider.dart';
import '../../../providers/audio_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final settingsAsync = ref.watch(appSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text(AppStrings.settings),
      ),
      body: settingsAsync.when(
        data: (s) => ListView(
          children: [
            _SettingsTile(title: AppStrings.appTheme, value: _themeLabel(s.themeMode),
                onTap: () => _showThemeDialog(context, ref, s.themeMode)),
            _CheckboxTile(title: AppStrings.vibrate, subtitle: AppStrings.vibrateOn,
                value: s.vibrate, onChanged: (v) => ref.read(mutableSettingsProvider.notifier).updateVibrate(v)),
            _CheckboxTile(title: AppStrings.sort, subtitle: AppStrings.sortBy,
                value: s.sortByBeat, onChanged: (v) => ref.read(mutableSettingsProvider.notifier).updateSortByBeat(v)),
            _CheckboxTile(title: AppStrings.awakeScreen, subtitle: AppStrings.keepAwake,
                value: s.awakScreen, onChanged: (v) => ref.read(mutableSettingsProvider.notifier).updateAwakeScreen(v)),
            _CheckboxTile(title: AppStrings.beatProgress, subtitle: AppStrings.showBeatProgress,
                value: s.beatProgress, onChanged: (v) => ref.read(mutableSettingsProvider.notifier).updateBeatProgress(v)),
            _CheckboxTile(title: AppStrings.beatCountDelay, subtitle: AppStrings.beatCountDelayDesc,
                value: s.beatCountDelay, onChanged: (v) => ref.read(mutableSettingsProvider.notifier).updateBeatCountDelay(v)),
            if (s.beatCountDelay)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${s.beatDelayMs}ms', style: Theme.of(context).textTheme.labelSmall),
                    Slider(
                      value: s.beatDelayMs.toDouble(), min: 0, max: 500, divisions: 50,
                      activeColor: colors.primary,
                      onChanged: (v) => ref.read(mutableSettingsProvider.notifier).updateBeatDelayMs(v.toInt()),
                    ),
                  ],
                ),
              ),
            _ActionTile(title: AppStrings.rebuildSoundFiles, subtitle: AppStrings.rebuildSoundFilesDesc,
                onTap: () => _showRebuildDialog(context, ref)),
            _InfoTile(title: AppStrings.batteryOptimisation, message: AppStrings.batteryOptimisationText),
            _ActionTile(title: AppStrings.mailUs, subtitle: AppStrings.developerEmail,
                onTap: () => _launchUrl('mailto:${AppStrings.developerEmail}')),
            _ActionTile(title: AppStrings.rateUs, onTap: () => _launchUrl('https://play.google.com/store/apps/details?id=com.example.musikano')),
            _ActionTile(title: AppStrings.likeOnFacebook, onTap: () => _launchUrl('https://facebook.com/musikano')),
            _ActionTile(title: AppStrings.privacyPolicy, onTap: () => _launchUrl('https://musikano.app/privacy')),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  String _themeLabel(String mode) {
    switch (mode) {
      case 'light': return AppStrings.themeLight;
      case 'dark': return AppStrings.themeDark;
      default: return AppStrings.themeSystem;
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref, String current) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.appTheme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['system', 'light', 'dark'].map((mode) {
            final label = _themeLabel(mode);
            return ListTile(
              leading: Radio<String>(value: mode, groupValue: current,
                  onChanged: (v) { if (v != null) ref.read(mutableSettingsProvider.notifier).updateThemeMode(v); Navigator.pop(ctx); }),
              title: Text(label),
              onTap: () { ref.read(mutableSettingsProvider.notifier).updateThemeMode(mode); Navigator.pop(ctx); },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showRebuildDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.rebuildSoundFiles),
        content: const Text(AppStrings.confirmRebuild),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text(AppStrings.cancel)),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.rebuildingAudioCache)),
              );
              await ref.read(audioEngineProvider).reloadAll();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.audioRebuildSuccess)),
              );
            },
            child: const Text(AppStrings.rebuild),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.title, required this.value, required this.onTap});
  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return ListTile(
      title: Text(title), subtitle: Text(value),
      trailing: Icon(Icons.chevron_right, color: colors.textHint),
      onTap: onTap,
    );
  }
}

class _CheckboxTile extends StatelessWidget {
  const _CheckboxTile({required this.title, required this.subtitle, required this.value, required this.onChanged});
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title), subtitle: Text(subtitle),
      value: value, onChanged: (v) => onChanged(v ?? false),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.title, this.subtitle, required this.onTap});
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return ListTile(
      title: Text(title), subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: Icon(Icons.chevron_right, color: colors.textHint),
      onTap: onTap,
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.title, required this.message});
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(message, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
