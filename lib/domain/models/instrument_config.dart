class InstrumentConfig {
  const InstrumentConfig({
    required this.instrumentId,
    required this.volume,
    required this.tempo,
    required this.tuner,
    required this.selectedPattern,
    required this.masterPlayEnabled,
    required this.isMuted,
    this.isPlaying = false,
    this.loopCount = 0,
  });

  final String instrumentId;
  final int volume;
  final int tempo;
  final int tuner;
  final String selectedPattern;
  final bool masterPlayEnabled;
  final bool isMuted;
  final bool isPlaying;
  final int loopCount;

  static const List<String> instrumentIds = ['tabla', 'tanpura', 'swar_mandal', 'manjeera'];

  static const defaults = {
    'tabla': InstrumentConfig(
      instrumentId: 'tabla', volume: 80, tempo: 120, tuner: 0,
      selectedPattern: 'Dadra 1', masterPlayEnabled: true, isMuted: false,
    ),
    'tanpura': InstrumentConfig(
      instrumentId: 'tanpura', volume: 60, tempo: 120, tuner: 0,
      selectedPattern: 'Kharaj', masterPlayEnabled: true, isMuted: false,
    ),
    'swar_mandal': InstrumentConfig(
      instrumentId: 'swar_mandal', volume: 50, tempo: 120, tuner: 0,
      selectedPattern: 'Basic', masterPlayEnabled: false, isMuted: false,
    ),
    'manjeera': InstrumentConfig(
      instrumentId: 'manjeera', volume: 70, tempo: 120, tuner: 0,
      selectedPattern: 'Default', masterPlayEnabled: false, isMuted: false,
    ),
  };

  InstrumentConfig copyWith({
    String? instrumentId,
    int? volume,
    int? tempo,
    int? tuner,
    String? selectedPattern,
    bool? masterPlayEnabled,
    bool? isMuted,
    bool? isPlaying,
    int? loopCount,
  }) {
    return InstrumentConfig(
      instrumentId: instrumentId ?? this.instrumentId,
      volume: volume ?? this.volume,
      tempo: tempo ?? this.tempo,
      tuner: tuner ?? this.tuner,
      selectedPattern: selectedPattern ?? this.selectedPattern,
      masterPlayEnabled: masterPlayEnabled ?? this.masterPlayEnabled,
      isMuted: isMuted ?? this.isMuted,
      isPlaying: isPlaying ?? this.isPlaying,
      loopCount: loopCount ?? this.loopCount,
    );
  }
}

List<String> patternsForInstrument(String instrumentId, String taalName) {
  switch (instrumentId) {
    case 'tabla':
      return ['${taalName} 1', '${taalName} 2', '${taalName} 3'];
    case 'tanpura':
      return ['Kharaj', 'Madhya', 'Taar', 'Mishra'];
    case 'swar_mandal':
      return ['Basic Aroha', 'Basic Avaroha', 'Mishra Aroha', 'Mishra Avaroha'];
    case 'manjeera':
      return ['Default', 'Fast', 'Slow'];
    default:
      return ['Default'];
  }
}
