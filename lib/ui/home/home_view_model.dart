import 'package:flutter/foundation.dart';

import '../../data/repositories/reading_repository.dart';
import '../../domain/models/heart_reading.dart';

/// Logika layar utama: catatan terakhir, riwayat, tambah, dan hapus.
class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required ReadingRepository repository, DateTime Function()? clock})
      : _repository = repository,
        _clock = clock ?? DateTime.now {
    _repository.addListener(notifyListeners);
  }

  final ReadingRepository _repository;
  final DateTime Function() _clock; // bisa diganti di test

  List<HeartReading> get readings => _repository.readings;
  HeartReading? get latest => readings.isEmpty ? null : readings.first;
  List<HeartReading> get history => readings.skip(1).toList();

  Future<void> add({required int bpm, String note = ''}) {
    final now = _clock();
    return _repository.add(HeartReading(
      id: now.microsecondsSinceEpoch.toString(),
      bpm: bpm,
      measuredAt: now,
      note: note.trim(),
    ));
  }

  Future<void> remove(String id) => _repository.remove(id);

  @override
  void dispose() {
    _repository.removeListener(notifyListeners);
    super.dispose();
  }
}
