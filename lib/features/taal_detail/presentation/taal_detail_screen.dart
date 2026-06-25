import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:vibration/vibration.dart';
import '../../../core/constants/strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/beat_circle.dart';
import '../../../core/widgets/scale_selector.dart';
import '../../../providers/playback_provider.dart';
import '../../../providers/taal_provider.dart';
import '../../../providers/favourites_provider.dart';
import '../../../providers/settings_provider.dart';
import '../../../providers/audio_provider.dart';
import 'widgets/instrument_card_tabla.dart';
import 'widgets/instrument_card_tanpura.dart';
import 'widgets/instrument_card_swar_mandal.dart';
import 'widgets/instrument_card_manjeera.dart';

class TaalDetailScreen extends ConsumerStatefulWidget {
  const TaalDetailScreen({super.key, required this.taalId});
  final String taalId;

  @override
  ConsumerState<TaalDetailScreen> createState() => _TaalDetailScreenState();
}

class _TaalDetailScreenState extends ConsumerState<TaalDetailScreen> {
  Timer? _beatTimer;
  int _currentBeat = 0;
  bool _isMasterPlaying = false;

  @override
  void dispose() {
    _beatTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final taals = ref.watch(allTaalsProvider);
    final taal = taals.firstWhere((t) => t.id == widget.taalId);
    final selectedScale = ref.watch(selectedScaleProvider(widget.taalId));
    final favouriteIdsAsync = ref.watch(favouritesTaalIdsProvider);
    final settingsAsync = ref.watch(appSettingsProvider);
    final isFav = favouriteIdsAsync.maybeWhen(data: (ids) => ids.contains(taal.id), orElse: () => false);
    final bpm = 120;
    final showProgress = settingsAsync.maybeWhen(data: (s) => s.beatProgress, orElse: () => true);


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (_isMasterPlaying) _stopMaster(taal.id);
                context.pop();
              },
            ),
            title: Text('${taal.name} (${taal.beatCount})'),
            actions: [
              IconButton(
                icon: Icon(isFav ? Icons.star : Icons.star_outline,
                    color: isFav ? colors.primary : colors.textHint),
                onPressed: () => ref.read(mutableFavouritesProvider.notifier).toggleFavourite(taal.id),
                tooltip: 'Toggle favourite',
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => context.push('/settings'),
                tooltip: AppStrings.settings,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BeatCircle(
                        beatNumber: _currentBeat,
                        isAnimating: _isMasterPlaying,
                        beatProgress: taal.beatCount > 0 ? (_currentBeat % taal.beatCount) / taal.beatCount : 0,
                        showProgress: showProgress,
                      ),
                      ScaleSelector(
                        selectedScale: selectedScale,
                        onMinusPressed: () => ref.read(selectedScaleProvider(widget.taalId).notifier).cycleDown(),
                        onPlusPressed: () => ref.read(selectedScaleProvider(widget.taalId).notifier).cycleUp(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      taal.bol,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic, color: colors.textSecondary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity, height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isMasterPlaying ? colors.danger : colors.accent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        if (_isMasterPlaying) {
                          _stopMaster(taal.id);
                        } else {
                          _startMaster(taal.id, bpm);
                        }
                      },
                      child: Text(
                        _isMasterPlaying ? AppStrings.stop : AppStrings.play,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _card(InstrumentCardTabla(taalId: taal.id)),
              _card(InstrumentCardTanpura(taalId: taal.id)),
              _card(InstrumentCardSwarMandal(taalId: taal.id)),
              _card(InstrumentCardManjeera(taalId: taal.id)),
              const SizedBox(height: 24),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _card(Widget w) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: w,
  );

  void _startMaster(String id, int bpm) async {
    setState(() => _isMasterPlaying = true);
    _currentBeat = 0;
    final engine = ref.read(audioEngineProvider);
    final instrumentIds = ['tabla', 'tanpura', 'swar_mandal', 'manjeera'];
    final aktif = <String>[];
    for (final instId in instrumentIds) {
      final config = ref.read(instrumentConfigNotifierProvider(id, instId));
      if (config.masterPlayEnabled) {
        aktif.add(instId);
        await engine.loadAsset(instId, config.selectedPattern);
        ref.read(instrumentConfigNotifierProvider(id, instId).notifier).setPlaying(true);
      }
    }
    if (aktif.isNotEmpty) {
      await engine.playAllActive(aktif);
    }
    final settings = ref.read(appSettingsProvider).maybeWhen(
      data: (s) => s, orElse: () => null,
    );
    if (settings?.awakScreen ?? true) {
      WakelockPlus.enable();
    }
    final delayMs = (settings?.beatCountDelay ?? false) ? (settings?.beatDelayMs ?? 0) : 0;
    engine.startBeatPulse(bpm, (beat) {
      if (!mounted) return;
      void doUpdate() {
        if (mounted) {
          setState(() => _currentBeat = beat);
          if (settings?.vibrate ?? false) {
            Vibration.vibrate(duration: 50);
          }
        }
      }
      if (delayMs > 0) {
        Future.delayed(Duration(milliseconds: delayMs), doUpdate);
      } else {
        doUpdate();
      }
    });
  }

  void _stopMaster(String id) async {
    setState(() => _isMasterPlaying = false);
    _currentBeat = 0;
    _beatTimer?.cancel();
    final engine = ref.read(audioEngineProvider);
    await engine.stopAll();
    engine.stopBeatPulse();
    WakelockPlus.disable();
    for (final instId in ['tabla', 'tanpura', 'swar_mandal', 'manjeera']) {
      ref.read(instrumentConfigNotifierProvider(id, instId).notifier)
        ..setPlaying(false)
        ..resetLoop();
    }
  }
}
