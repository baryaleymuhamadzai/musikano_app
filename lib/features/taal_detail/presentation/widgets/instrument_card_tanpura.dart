import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/shared_widgets.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../../../core/widgets/pattern_selector.dart';
import '../../../../core/widgets/master_play_toggle.dart';
import '../../../../core/widgets/control_bottom_sheet.dart';
import '../../../../core/audio/audio_engine.dart';
import '../../../../domain/models/instrument_config.dart';
import '../../../../providers/playback_provider.dart';
import '../../../../providers/audio_provider.dart';

class InstrumentCardTanpura extends ConsumerWidget {
  const InstrumentCardTanpura({super.key, required this.taalId});
  final String taalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final config = ref.watch(instrumentConfigNotifierProvider(taalId, 'tanpura'));
    final engine = ref.read(audioEngineProvider);

    return InstrumentCardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.tanpura, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text('18 ${AppStrings.patterns}', style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.build),
                    onPressed: () => _showWrenchSheet(context),
                    tooltip: 'Configure Tanpura',
                  ),
                  SizedBox(
                    width: 36, height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: config.isPlaying ? colors.danger : colors.accent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      onPressed: () => _toggleSolo(context, ref, engine, config),
                      child: Icon(config.isPlaying ? Icons.stop : Icons.play_arrow, size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          PatternSelector(
            pattern: config.selectedPattern,
            onPreviousPressed: () => _cyclePattern(ref, config.selectedPattern, -1),
            onNextPressed: () => _cyclePattern(ref, config.selectedPattern, 1),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PillButton(label: AppStrings.volume, value: '${config.volume}',
                  onPressed: () => _openSlider(context, ref, 'Volume', config.volume, 0, 100, (v) {
                ref.read(instrumentConfigNotifierProvider(taalId, 'tanpura').notifier).updateVolume(v);
              })),
              PillButton(label: AppStrings.tempo, value: '${config.tempo}',
                  onPressed: () => _openSlider(context, ref, 'Tempo (BPM)', config.tempo, 40, 300, (v) {
                ref.read(instrumentConfigNotifierProvider(taalId, 'tanpura').notifier).updateTempo(v);
              })),
              PillButton(label: AppStrings.tuner, value: '${config.tuner}',
                  onPressed: () => _openSlider(context, ref, 'Tuner (semitones)', config.tuner, -6, 6, (v) {
                ref.read(instrumentConfigNotifierProvider(taalId, 'tanpura').notifier).updateTuner(v);
              })),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MasterPlayToggle(
                value: config.masterPlayEnabled,
                onChanged: (v) => ref.read(instrumentConfigNotifierProvider(taalId, 'tanpura').notifier).enableMasterPlay(v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _cyclePattern(WidgetRef ref, String current, int dir) {
    const patterns = ['Kharaj', 'Madhya', 'Taar', 'Mishra'];
    final i = patterns.indexOf(current);
    final next = patterns[(i + dir + patterns.length) % patterns.length];
    ref.read(instrumentConfigNotifierProvider(taalId, 'tanpura').notifier).updatePattern(next);
  }

  void _openSlider(BuildContext context, WidgetRef ref, String title, int val, int min, int max, void Function(int) onApply) {
    ControlBottomSheet.show(context: context, title: title, initialValue: val, min: min, max: max, onApply: onApply);
  }

  void _toggleSolo(BuildContext context, WidgetRef ref, AudioEngine engine, InstrumentConfig config) async {
    if (config.isPlaying) {
      await engine.stopInstrument('tanpura');
      ref.read(instrumentConfigNotifierProvider(taalId, 'tanpura').notifier)
        ..setPlaying(false)
        ..resetLoop();
    } else {
      await engine.loadAsset('tanpura', config.selectedPattern);
      await engine.playInstrument('tanpura');
      ref.read(instrumentConfigNotifierProvider(taalId, 'tanpura').notifier).setPlaying(true);
    }
  }

  void _showWrenchSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tanpura Settings', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            const Text('String tuning, style settings here.'),
            const SizedBox(height: 24),
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
          ],
        ),
      ),
    );
  }
}
