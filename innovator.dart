class Innovator {
  final String id;
  final String name;
  final String country;
  final String region;
  final String field;
  final int? birthYear;
  final int? deathYear;
  final String summary;
  final String biography;
  final List<String> achievements;
  final List<String> tags;

  const Innovator({
    required this.id,
    required this.name,
    required this.country,
    required this.region,
    required this.field,
    required this.birthYear,
    required this.deathYear,
    required this.summary,
    required this.biography,
    required this.achievements,
    required this.tags,
  });

  String get years {
    final b = birthYear?.toString() ?? '?';
    final d = deathYear?.toString() ?? 'present';
    return '$b – $d';
  }
}
