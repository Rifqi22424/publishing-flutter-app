import 'package:flutter_test/flutter_test.dart';
import 'package:sesi15_publikasi_aplikasi/domain/heart_rate_rules.dart';

void main() {
  group('statusOf (nilai batas 60 dan 100)', () {
    test('59 Rendah, 60 Normal', () {
      expect(HeartRateRules.statusOf(59), HeartStatus.rendah);
      expect(HeartRateRules.statusOf(60), HeartStatus.normal);
    });

    test('100 Normal, 101 Tinggi', () {
      expect(HeartRateRules.statusOf(100), HeartStatus.normal);
      expect(HeartRateRules.statusOf(101), HeartStatus.tinggi);
    });
  });

  group('validateBpm', () {
    test('72 diterima', () {
      expect(HeartRateRules.validateBpm('72'), isNull);
    });

    test('kosong dan huruf ditolak', () {
      expect(HeartRateRules.validateBpm(''), 'Detak jantung harus berupa angka');
      expect(HeartRateRules.validateBpm('tujuh'), 'Detak jantung harus berupa angka');
    });

    test('di luar 30-220 ditolak, tepat di batas diterima', () {
      expect(HeartRateRules.validateBpm('29'), isNotNull);
      expect(HeartRateRules.validateBpm('30'), isNull);
      expect(HeartRateRules.validateBpm('220'), isNull);
      expect(HeartRateRules.validateBpm('221'), isNotNull);
    });
  });
}
