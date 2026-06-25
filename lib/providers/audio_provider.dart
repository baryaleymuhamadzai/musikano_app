import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/audio/audio_engine.dart';

final audioEngineProvider = Provider<AudioEngine>((_) => AudioEngine());
