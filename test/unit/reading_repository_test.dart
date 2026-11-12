import 'package:flutter_test/flutter_test.dart';
import 'package:sesi15_publikasi_aplikasi/data/repositories/reading_repository.dart';
import 'package:sesi15_publikasi_aplikasi/data/services/reading_storage.dart';
import 'package:sesi15_publikasi_aplikasi/domain/models/heart_reading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

HeartReading catatan(String id, int bpm, DateTime t) =>
    HeartReading(id: id, bpm: bpm, measuredAt: t, note: 'tes');

void main() {
  // Penyimpanan tiruan di memori, pengganti penyimpanan HP.
  setUp(() => SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty());

  test('catatan terbaru selalu di atas', () async {
    final repo = ReadingRepository(storage: ReadingStorage(SharedPreferencesAsync()));
    await repo.add(catatan('a', 70, DateTime(2026, 11, 10, 7)));
    await repo.add(catatan('b', 80, DateTime(2026, 11, 12, 7)));
    await repo.add(catatan('c', 75, DateTime(2026, 11, 11, 7)));

    expect(repo.readings.map((r) => r.id), ['b', 'c', 'a']);
  });

  test('catatan tetap ada setelah aplikasi dibuka ulang', () async {
    final pertama = ReadingRepository(storage: ReadingStorage(SharedPreferencesAsync()));
    await pertama.add(catatan('a', 72, DateTime(2026, 11, 12, 7, 30)));

    final kedua = ReadingRepository(storage: ReadingStorage(SharedPreferencesAsync()));
    await kedua.load();

    expect(kedua.readings, hasLength(1));
    expect(kedua.readings.first.bpm, 72);
    expect(kedua.readings.first.measuredAt, DateTime(2026, 11, 12, 7, 30));
  });

  test('hapus menghilangkan catatan', () async {
    final repo = ReadingRepository(storage: ReadingStorage(SharedPreferencesAsync()));
    await repo.add(catatan('a', 72, DateTime(2026, 11, 12)));
    await repo.remove('a');

    expect(repo.readings, isEmpty);
  });
}
