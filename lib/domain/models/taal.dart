class Taal {
  const Taal({
    required this.id,
    required this.name,
    required this.beatCount,
    required this.bol,
    required this.variationCount,
    this.isPremium = false,
  });

  final String id;
  final String name;
  final int beatCount;
  final String bol;
  final int variationCount;
  final bool isPremium;
}
