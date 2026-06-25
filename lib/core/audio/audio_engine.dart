import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class AudioEngine {
  static final AudioEngine _instance = AudioEngine._internal();
  factory AudioEngine() => _instance;
  AudioEngine._internal();

  final Map<String, AudioPlayer> _players = {};
  final Map<String, int> _savedVolumes = {};
  StreamSubscription<dynamic>? _interruptionSub;
  bool _isInitialized = false;

  Timer? _beatTimer;
  final StreamController<int> _beatController = StreamController<int>.broadcast();

  Stream<int> get beatStream => _beatController.stream;

  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
      // interruption handling - API varies by audio_session version
      _isInitialized = true;
    } catch (_) {}
  }

  AudioPlayer _player(String id) => _players.putIfAbsent(id, () => AudioPlayer());

  Future<void> loadAsset(String instrumentId, String pattern) async {
    final player = _player(instrumentId);
    final path = 'assets/audio/$instrumentId/${pattern.toLowerCase().replaceAll(' ', '_')}.mp3';
    try {
      await player.setAsset(path);
      player.setLoopMode(LoopMode.one);
    } catch (_) {}
  }

  Future<void> playInstrument(String instrumentId) async {
    try {
      await _player(instrumentId).seek(Duration.zero);
      await _player(instrumentId).play();
    } catch (_) {}
  }

  Future<void> stopInstrument(String instrumentId) async {
    try {
      await _player(instrumentId).stop();
    } catch (_) {}
  }

  Future<void> playAllActive(List<String> ids) async {
    if (ids.isEmpty) return;
    await Future.wait(ids.map((id) async {
      try {
        await _player(id).seek(Duration.zero);
        await _player(id).play();
      } catch (_) {}
    }));
  }

  Future<void> stopAll() async {
    for (final p in _players.values) {
      try { await p.stop(); } catch (_) {}
    }
    _beatTimer?.cancel();
    _beatTimer = null;
  }

  Future<void> setVolume(String id, int volume) async {
    try { await _player(id).setVolume(volume / 100.0); } catch (_) {}
  }

  Future<void> setSpeed(String id, double speed) async {
    try { await _player(id).setSpeed(speed.clamp(0.5, 2.0)); } catch (_) {}
  }

  Future<void> mute(String id) async {
    try {
      _savedVolumes[id] = (_player(id).volume * 100).round();
      await _player(id).setVolume(0);
    } catch (_) {}
  }

  Future<void> unmute(String id) async {
    final vol = _savedVolumes.remove(id) ?? 80;
    await setVolume(id, vol);
  }

  Stream<Duration> positionStream(String id) => _player(id).positionStream;
  Stream<Duration?> durationStream(String id) => _player(id).durationStream;
  Stream<PlayerState> stateStream(String id) => _player(id).playerStateStream;

  void startBeatPulse(int bpm, void Function(int beat) onBeat) {
    _beatTimer?.cancel();
    if (bpm <= 0) return;
    int count = 0;
    final interval = Duration(milliseconds: (60000 / bpm).round());
    _beatTimer = Timer.periodic(interval, (_) {
      count++;
      _beatController.add(count);
      onBeat(count);
    });
  }

  void stopBeatPulse() {
    _beatTimer?.cancel();
    _beatTimer = null;
  }

  Future<void> disposeAll() async {
    _beatTimer?.cancel();
    await _interruptionSub?.cancel();
    for (final p in _players.values) {
      await p.dispose();
    }
    _players.clear();
    _savedVolumes.clear();
    _isInitialized = false;
  }

  Future<void> reloadAll() async {
    await disposeAll();
    await initialize();
  }
}
