import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/heart_reading.dart';

/// Menyimpan catatan di HP ini saja (SharedPreferences), tanpa internet.
class ReadingStorage {
  ReadingStorage(this._prefs);

  static const _key = 'readings';
  final SharedPreferencesAsync _prefs;

  Future<List<HeartReading>> readAll() async {
    final text = await _prefs.getString(_key);
    if (text == null) return [];
    final list = jsonDecode(text) as List<dynamic>;
    return [for (final item in list) HeartReading.fromJson(item as Map<String, dynamic>)];
  }

  Future<void> saveAll(List<HeartReading> readings) =>
      _prefs.setString(_key, jsonEncode([for (final r in readings) r.toJson()]));
}
