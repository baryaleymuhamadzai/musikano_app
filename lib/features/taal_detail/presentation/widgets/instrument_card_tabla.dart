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

class InstrumentCardTabla extends ConsumerWidget {
  const InstrumentCardTabla({super.key, required this.taalId});
  final String taalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final config = ref.watch(instrumentConfigNotifierProvider(taalId, 'tabla'));
    final engine = ref.read(audioEngineProvider);

    return InstrumentCardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context, ref, colors, config, engine),
          const SizedBox(height: 8),
          _progressBar(config, context),
          const SizedBox(height: 12),
          PatternSelector(
            pattern: config.selectedPattern,
            onPreviousPressed: () => _cyclePattern(ref, taalId, 'tabla', config.selectedPattern, -1),
            onNextPressed: () => _cyclePattern(ref, taalId, 'tabla', config.selectedPattern, 1),
          ),
          const SizedBox(height: 12),
          _controls(context, ref, config),
          const SizedBox(height: 12),
          _footer(context, ref, config),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, WidgetRef ref, AppColors colors, InstrumentConfig config, AudioEngine engine) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.tabla, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text('${AppStrings.bayan}: C', style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.build),
              onPressed: () => _showWrenchSheet(context, ref),
              tooltip: 'Configure Tabla',
            ),
            IconButton(
              icon: Icon(
                config.isMuted ? Icons.volume_off : Icons.volume_up,
                color: config.isMuted ? colors.danger : colors.textPrimary,
              ),
              onPressed: () => ref.read(instrumentConfigNotifierProvider(taalId, 'tabla').notifier).toggleMute(),
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
                onPressed: () => _toggleSolo(context, ref, engine, config),
                child: Icon(config.isPlaying ? Icons.stop : Icons.play_arrow, size: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _progressBar(InstrumentConfig config, BuildContext context) {
    return StreamBuilder<Duration>(
      stream: AudioEngine().positionStream(config.instrumentId),
      builder: (_, snap) {
        final pos = snap.data ?? Duration.zero;
        final fmt = (Duration d) {
          final h = d.inHours.toString().padLeft(2, '0');
          final m = (d.inMinutes % 60).toString().padLeft(2, '0');
          final s = (d.inSeconds % 60).toString().padLeft(2, '0');
          return '$h:$m:$s';
        };
        return Text(
          '${fmt(pos)} / ${fmt(Duration.zero)}',
          style: Theme.of(context).textTheme.labelSmall,
        );
      },
    );
  }

  Widget _controls(BuildContext context, WidgetRef ref, InstrumentConfig config) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PillButton(
          label: AppStrings.volume, value: '${config.volume}',
          onPressed: () => _openSlider(context, ref, 'tabla', 'Volume', config.volume, 0, 100, (v) {
            ref.read(instrumentConfigNotifierProvider(taalId, 'tabla').notifier).updateVolume(v);
          }),
        ),
        PillButton(
          label: AppStrings.tempo, value: '${config.tempo}',
          onPressed: () => _openSlider(context, ref, 'tabla', 'Tempo (BPM)', config.tempo, 40, 300, (v) {
            ref.read(instrumentConfigNotifierProvider(taalId, 'tabla').notifier).updateTempo(v);
          }),
        ),
        PillButton(
          label: AppStrings.tuner, value: '${config.tuner}',
          onPressed: () => _openSlider(context, ref, 'tabla', 'Tuner (semitones)', config.tuner, -6, 6, (v) {
            ref.read(instrumentConfigNotifierProvider(taalId, 'tabla').notifier).updateTuner(v);
          }),
        ),
      ],
    );
  }

  Widget _footer(BuildContext context, WidgetRef ref, InstrumentConfig config) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${AppStrings.loopCount}: ${config.loopCount > 9999 ? '9999+' : config.loopCount}',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        MasterPlayToggle(
          value: config.masterPlayEnabled,
          onChanged: (v) => ref.read(instrumentConfigNotifierProvider(taalId, 'tabla').notifier).enableMasterPlay(v),
        ),
      ],
    );
  }

  void _cyclePattern(WidgetRef ref, String tId, String instId, String current, int dir) {
    final patterns = _patterns(instId);
    final i = patterns.indexOf(current);
    final next = patterns[(i + dir + patterns.length) % patterns.length];
    ref.read(instrumentConfigNotifierProvider(tId, instId).notifier).updatePattern(next);
  }

  List<String> _patterns(String id) {
    switch (id) {
      case 'tabla': return ['${taalId} 1', '${taalId} 2', '${taalId} 3'];
      case 'tanpura': return ['Kharaj', 'Madhya', 'Taar', 'Mishra'];
      case 'swar_mandal': return ['Basic Aroha', 'Basic Avaroha', 'Mishra Aroha', 'Mishra Avaroha'];
      default: return ['Default'];
    }
  }

  void _openSlider(BuildContext context, WidgetRef ref, String instId, String title, int val, int min, int max, void Function(int) onApply) {
    ControlBottomSheet.show(
      context: context, title: title, initialValue: val, min: min, max: max,
      onApply: onApply,
    );
  }

  void _toggleSolo(BuildContext context, WidgetRef ref, AudioEngine engine, InstrumentConfig config) async {
    if (config.isPlaying) {
      await engine.stopInstrument('tabla');
      ref.read(instrumentConfigNotifierProvider(taalId, 'tabla').notifier)
        ..setPlaying(false)
        ..resetLoop();
    } else {
      await engine.loadAsset('tabla', config.selectedPattern);
      await engine.playInstrument('tabla');
      ref.read(instrumentConfigNotifierProvider(taalId, 'tabla').notifier).setPlaying(true);
    }
  }

  void _showWrenchSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tabla Settings', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            const Text('Bayan Tuning:'),
            const SizedBox(height: 8),
            const Text('Dayan Tuning:'),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
