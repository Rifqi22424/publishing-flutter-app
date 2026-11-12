import 'package:flutter_test/flutter_test.dart';
import 'package:sesi15_publikasi_aplikasi/data/repositories/reading_repository.dart';
import 'package:sesi15_publikasi_aplikasi/data/services/reading_storage.dart';
import 'package:sesi15_publikasi_aplikasi/ui/home/home_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() => SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty());

  test('belum ada catatan: latest null dan riwayat kosong', () {
    final vm = HomeViewModel(repository: ReadingRepository(storage: ReadingStorage(SharedPreferencesAsync())));
    expect(vm.latest, isNull);
    expect(vm.history, isEmpty);
  });

  test('add memakai waktu sekarang dan merapikan catatan', () async {
    var jam = DateTime(2026, 11, 12, 7, 0);
    final vm = HomeViewModel(
      repository: ReadingRepository(storage: ReadingStorage(SharedPreferencesAsync())),
      clock: () => jam,
    );
    await vm.add(bpm: 68, note: '  bangun tidur ');
    jam = DateTime(2026, 11, 12, 19, 0);
    await vm.add(bpm: 104);

    expect(vm.latest!.bpm, 104);
    expect(vm.latest!.measuredAt, DateTime(2026, 11, 12, 19, 0));
    expect(vm.history.single.note, 'bangun tidur');
  });
}
