import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/instrument_config.dart';

part 'playback_provider.g.dart';

@riverpod
class SelectedScale extends _$SelectedScale {
  @override
  String build(String taalId) => 'C';

  void setScale(String s) => state = s;
  void cycleUp() => _cycle(1);
  void cycleDown() => _cycle(-1);

  void _cycle(int dir) {
    const scales = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];
    final i = scales.indexOf(state);
    state = scales[(i + dir + scales.length) % scales.length];
  }
}

@riverpod
class InstrumentConfigNotifier extends _$InstrumentConfigNotifier {
  @override
  InstrumentConfig build(String taalId, String instrumentId) {
    return InstrumentConfig.defaults[instrumentId]!;
  }

  Future<void> updateVolume(int v) async {
    state = state.copyWith(volume: v.clamp(0, 100));
  }

  Future<void> updateTempo(int t) async {
    state = state.copyWith(tempo: t.clamp(40, 300));
  }

  Future<void> updateTuner(int s) async {
    state = state.copyWith(tuner: s.clamp(-6, 6));
  }

  Future<void> updatePattern(String p) async {
    state = state.copyWith(selectedPattern: p);
  }

  Future<void> toggleMute() async {
    state = state.copyWith(isMuted: !state.isMuted);
  }

  void enableMasterPlay(bool v) {
    state = state.copyWith(masterPlayEnabled: v);
  }

  void setPlaying(bool v) {
    state = state.copyWith(isPlaying: v);
  }

  void incrementLoop() {
    state = state.copyWith(loopCount: state.loopCount + 1);
  }

  void resetLoop() {
    state = state.copyWith(loopCount: 0);
  }
}


