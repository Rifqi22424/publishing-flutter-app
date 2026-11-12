/// Status sederhana detak jantung saat istirahat (orang dewasa).
///
/// Batas 60-100 denyut per menit adalah rentang umum untuk orang dewasa
/// yang sedang istirahat. Ini informasi umum, BUKAN diagnosis.
enum HeartStatus {
  rendah('Rendah'),
  normal('Normal'),
  tinggi('Tinggi');

  const HeartStatus(this.label);
  final String label;
}

class HeartRateRules {
  static const int minBpm = 30;
  static const int maxBpm = 220;

  static HeartStatus statusOf(int bpm) {
    if (bpm < 60) return HeartStatus.rendah;
    if (bpm > 100) return HeartStatus.tinggi;
    return HeartStatus.normal;
  }

  /// Validator kolom BPM di formulir.
  static String? validateBpm(String? value) {
    final bpm = int.tryParse(value?.trim() ?? '');
    if (bpm == null) return 'Detak jantung harus berupa angka';
    if (bpm < minBpm || bpm > maxBpm) {
      return 'Masukkan angka antara $minBpm dan $maxBpm';
    }
    return null;
  }
}
