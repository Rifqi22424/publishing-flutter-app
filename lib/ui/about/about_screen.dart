import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Layar Tentang: versi aplikasi, peringatan medis, dan privasi.
///
/// Versi dibaca dari aplikasi yang terpasang (asalnya dari pubspec.yaml),
/// jadi tidak perlu ditulis ulang di kode.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: const Color(0xFFC8323F),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(Icons.monitor_heart, color: Colors.white, size: 52),
            ),
          ),
          const SizedBox(height: 12),
          Text('NusaJantung', style: text.headlineSmall, textAlign: TextAlign.center),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              final info = snapshot.data;
              return Text(
                info == null ? '' : 'Versi ${info.version} (build ${info.buildNumber})',
                key: const Key('teks-versi'),
                textAlign: TextAlign.center,
              );
            },
          ),
          const SizedBox(height: 20),
          Card(
            color: scheme.errorContainer,
            child: const ListTile(
              leading: Icon(Icons.health_and_safety_outlined),
              title: Text('Bukan alat medis'),
              subtitle: Text(
                'NusaJantung hanya mencatat angka yang Anda masukkan. Aplikasi ini '
                'tidak mendiagnosis penyakit dan tidak menggantikan dokter. '
                'Dalam keadaan darurat, hubungi 119.',
              ),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Privasi'),
              subtitle: Text(
                'Catatan hanya disimpan di HP ini dan tidak dikirim ke internet. '
                'Menghapus aplikasi akan menghapus semua catatan.',
              ),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.school_outlined),
              title: Text('Contoh mata kuliah'),
              subtitle: Text('Pemrograman Perangkat Mobile (IF31033), Universitas Nusa Putra.'),
            ),
          ),
        ],
      ),
    );
  }
}
