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

class InstrumentCardManjeera extends ConsumerWidget {
  const InstrumentCardManjeera({super.key, required this.taalId});
  final String taalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final config = ref.watch(instrumentConfigNotifierProvider(taalId, 'manjeera'));
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
                  Text(AppStrings.manjeera, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text('3 ${AppStrings.patterns}', style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      config.isMuted ? Icons.volume_off : Icons.volume_up,
                      color: config.isMuted ? colors.danger : colors.textPrimary,
                    ),
                    onPressed: () => ref.read(instrumentConfigNotifierProvider(taalId, 'manjeera').notifier).toggleMute(),
                    tooltip: 'Toggle mute',
                  ),
                  SizedBox(
                    width: 36, height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: config.isPlaying ? colors.danger : colors.accent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      onPressed: () => _toggleSolo(ref, engine, config),
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
                ref.read(instrumentConfigNotifierProvider(taalId, 'manjeera').notifier).updateVolume(v);
              })),
              PillButton(label: AppStrings.tempo, value: '${config.tempo}',
                  onPressed: () => _openSlider(context, ref, 'Tempo (BPM)', config.tempo, 40, 300, (v) {
                ref.read(instrumentConfigNotifierProvider(taalId, 'manjeera').notifier).updateTempo(v);
              })),
              PillButton(label: AppStrings.tuner, value: '${config.tuner}',
                  onPressed: () => _openSlider(context, ref, 'Tuner (semitones)', config.tuner, -6, 6, (v) {
                ref.read(instrumentConfigNotifierProvider(taalId, 'manjeera').notifier).updateTuner(v);
              })),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MasterPlayToggle(
                value: config.masterPlayEnabled,
                onChanged: (v) => ref.read(instrumentConfigNotifierProvider(taalId, 'manjeera').notifier).enableMasterPlay(v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _cyclePattern(WidgetRef ref, String current, int dir) {
    const patterns = ['Default', 'Fast', 'Slow'];
    final i = patterns.indexOf(current);
    final next = patterns[(i + dir + patterns.length) % patterns.length];
    ref.read(instrumentConfigNotifierProvider(taalId, 'manjeera').notifier).updatePattern(next);
  }

  void _openSlider(BuildContext context, WidgetRef ref, String title, int val, int min, int max, void Function(int) onApply) {
    ControlBottomSheet.show(context: context, title: title, initialValue: val, min: min, max: max, onApply: onApply);
  }

  void _toggleSolo(WidgetRef ref, AudioEngine engine, InstrumentConfig config) async {
    if (config.isPlaying) {
      await engine.stopInstrument('manjeera');
      ref.read(instrumentConfigNotifierProvider(taalId, 'manjeera').notifier)
        ..setPlaying(false)
        ..resetLoop();
    } else {
      await engine.loadAsset('manjeera', config.selectedPattern);
      await engine.playInstrument('manjeera');
      ref.read(instrumentConfigNotifierProvider(taalId, 'manjeera').notifier).setPlaying(true);
    }
  }
}
