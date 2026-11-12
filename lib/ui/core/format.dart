const _bulan = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];

/// Contoh: 12 Nov 2026, 07.30
String formatWaktu(DateTime t) {
  String dua(int n) => n.toString().padLeft(2, '0');
  return '${t.day} ${_bulan[t.month - 1]} ${t.year}, ${dua(t.hour)}.${dua(t.minute)}';
}
