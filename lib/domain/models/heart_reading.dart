/// Satu catatan detak jantung yang diukur pengguna.
class HeartReading {
  const HeartReading({
    required this.id,
    required this.bpm,
    required this.measuredAt,
    this.note = '',
  });

  final String id;
  final int bpm; // denyut per menit (beats per minute)
  final DateTime measuredAt;
  final String note;

  Map<String, Object> toJson() => {
        'id': id,
        'bpm': bpm,
        'measuredAt': measuredAt.toIso8601String(),
        'note': note,
      };

  factory HeartReading.fromJson(Map<String, dynamic> json) => HeartReading(
        id: json['id'] as String,
        bpm: json['bpm'] as int,
        measuredAt: DateTime.parse(json['measuredAt'] as String),
        note: json['note'] as String? ?? '',
      );
}
