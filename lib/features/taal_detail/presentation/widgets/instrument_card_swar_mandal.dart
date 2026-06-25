import 'dart:async';
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

class InstrumentCardSwarMandal extends ConsumerStatefulWidget {
  const InstrumentCardSwarMandal({super.key, required this.taalId});
  final String taalId;

  @override
  ConsumerState<InstrumentCardSwarMandal> createState() => _SwarMandalState();
}

class _SwarMandalState extends ConsumerState<InstrumentCardSwarMandal> {
  Timer? _strumTimer;
  int _intervalSeconds = 5;

  @override
  void dispose() {
    _strumTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final config = ref.watch(instrumentConfigNotifierProvider(widget.taalId, 'swar_mandal'));
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
                  Text(AppStrings.swarMandal, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text('117 ${AppStrings.raags}', style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
              Row(
                children: [
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
          const SizedBox(height: 8),
          PatternSelector(
            pattern: AppStrings.aroha,
            onPreviousPressed: () {},
            onNextPressed: () {},
          ),
          const SizedBox(height: 8),
          _intervalSelector(context, ref, config),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PillButton(label: AppStrings.volume, value: '${config.volume}',
                  onPressed: () => _openSlider(context, ref, 'Volume', config.volume, 0, 100, (v) {
                ref.read(instrumentConfigNotifierProvider(widget.taalId, 'swar_mandal').notifier).updateVolume(v);
              })),
              PillButton(label: AppStrings.tempo, value: '${config.tempo}',
                  onPressed: () => _openSlider(context, ref, 'Tempo (BPM)', config.tempo, 40, 300, (v) {
                ref.read(instrumentConfigNotifierProvider(widget.taalId, 'swar_mandal').notifier).updateTempo(v);
              })),
              PillButton(label: AppStrings.tuner, value: '${config.tuner}',
                  onPressed: () => _openSlider(context, ref, 'Tuner (semitones)', config.tuner, -6, 6, (v) {
                ref.read(instrumentConfigNotifierProvider(widget.taalId, 'swar_mandal').notifier).updateTuner(v);
              })),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MasterPlayToggle(
                value: config.masterPlayEnabled,
                onChanged: (v) => ref.read(instrumentConfigNotifierProvider(widget.taalId, 'swar_mandal').notifier).enableMasterPlay(v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _intervalSelector(BuildContext context, WidgetRef ref, InstrumentConfig config) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 36, height: 36,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                _intervalSeconds = [_intervalSeconds - 5, 5].reduce((a, b) => a > b ? a : b);
                _restartStrummer(ref);
              });
            },
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).extension<AppColors>()!.cardBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${AppStrings.interval}: ${_intervalSeconds}s',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 36, height: 36,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                _intervalSeconds = [_intervalSeconds + 5, 30].reduce((a, b) => a < b ? a : b);
                _restartStrummer(ref);
              });
            },
          ),
        ),
      ],
    );
  }

  void _restartStrummer(WidgetRef ref) {
    _strumTimer?.cancel();
    final cfg = ref.read(instrumentConfigNotifierProvider(widget.taalId, 'swar_mandal'));
    if (!cfg.isPlaying) return;
    final eng = ref.read(audioEngineProvider);
    _strumTimer = Timer.periodic(Duration(seconds: _intervalSeconds), (_) async {
      await eng.loadAsset('swar_mandal', cfg.selectedPattern);
      await eng.playInstrument('swar_mandal');
    });
  }

  void _cyclePattern(WidgetRef ref, String current, int dir) {
    const patterns = ['Basic Aroha', 'Basic Avaroha', 'Mishra Aroha', 'Mishra Avaroha'];
    final i = patterns.indexOf(current);
    final next = patterns[(i + dir + patterns.length) % patterns.length];
    ref.read(instrumentConfigNotifierProvider(widget.taalId, 'swar_mandal').notifier).updatePattern(next);
  }

  void _openSlider(BuildContext context, WidgetRef ref, String title, int val, int min, int max, void Function(int) onApply) {
    ControlBottomSheet.show(context: context, title: title, initialValue: val, min: min, max: max, onApply: onApply);
  }

  void _toggleSolo(WidgetRef ref, AudioEngine engine, InstrumentConfig config) async {
    if (config.isPlaying) {
      _strumTimer?.cancel();
      await engine.stopInstrument('swar_mandal');
      ref.read(instrumentConfigNotifierProvider(widget.taalId, 'swar_mandal').notifier)
        ..setPlaying(false)
        ..resetLoop();
    } else {
      await engine.loadAsset('swar_mandal', config.selectedPattern);
      await engine.playInstrument('swar_mandal');
      ref.read(instrumentConfigNotifierProvider(widget.taalId, 'swar_mandal').notifier).setPlaying(true);
      _restartStrummer(ref);
    }
  }
}
