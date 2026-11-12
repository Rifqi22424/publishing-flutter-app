import 'package:flutter/foundation.dart';

import '../../domain/models/heart_reading.dart';
import '../services/reading_storage.dart';

/// Sumber kebenaran daftar catatan detak jantung (terbaru di atas).
class ReadingRepository extends ChangeNotifier {
  ReadingRepository({required ReadingStorage storage}) : _storage = storage;

  final ReadingStorage _storage;
  List<HeartReading> _readings = [];

  List<HeartReading> get readings => List.unmodifiable(_readings);

  Future<void> load() async {
    _readings = await _storage.readAll();
    notifyListeners();
  }

  Future<void> add(HeartReading reading) async {
    _readings = [reading, ..._readings]
      ..sort((a, b) => b.measuredAt.compareTo(a.measuredAt));
    notifyListeners();
    await _storage.saveAll(_readings);
  }

  Future<void> remove(String id) async {
    _readings = _readings.where((r) => r.id != id).toList();
    notifyListeners();
    await _storage.saveAll(_readings);
  }
}
