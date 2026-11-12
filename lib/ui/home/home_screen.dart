import 'package:flutter/material.dart';

import '../../domain/heart_rate_rules.dart';
import '../../domain/models/heart_reading.dart';
import '../about/about_screen.dart';
import '../add_reading/add_reading_screen.dart';
import '../core/format.dart';
import '../core/status_color.dart';
import 'home_view_model.dart';

/// Layar utama: peringatan medis, catatan terakhir, dan riwayat.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  Future<void> _openForm(BuildContext context) async {
    final NewReading? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddReadingScreen()),
    );
    if (result == null) return; // pengguna menekan Kembali
    await viewModel.add(bpm: result.bpm, note: result.note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaJantung'),
        actions: [
          IconButton(
            key: const Key('tombol-tentang'),
            tooltip: 'Tentang aplikasi',
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutScreen()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('tombol-catat'),
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Catat'),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final latest = viewModel.latest;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              const _Disclaimer(),
              const SizedBox(height: 12),
              if (latest == null)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(Icons.monitor_heart_outlined, size: 64),
                      SizedBox(height: 12),
                      Text(
                        'Belum ada catatan.\nTekan Catat untuk memasukkan detak jantung.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else ...[
                _LatestCard(reading: latest),
                if (viewModel.history.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 20, 4, 4),
                    child: Text('Riwayat', style: Theme.of(context).textTheme.titleMedium),
                  ),
                for (final reading in viewModel.history)
                  Dismissible(
                    key: ValueKey(reading.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Theme.of(context).colorScheme.errorContainer,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete),
                    ),
                    onDismissed: (_) => viewModel.remove(reading.id),
                    child: _ReadingTile(reading: reading),
                  ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _Disclaimer extends StatelessWidget {
  const _Disclaimer();

  @override
  Widget build(BuildContext context) {
    return Card(
      key: const Key('disclaimer'),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const ListTile(
        leading: Icon(Icons.health_and_safety_outlined),
        title: Text('Bukan alat medis'),
        subtitle: Text('Catatan pribadi saja. Jika merasa sakit, hubungi tenaga kesehatan atau 119.'),
      ),
    );
  }
}

class _LatestCard extends StatelessWidget {
  const _LatestCard({required this.reading});

  final HeartReading reading;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final status = HeartRateRules.statusOf(reading.bpm);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Terakhir diukur', style: text.titleMedium),
            Text('${reading.bpm}', key: const Key('teks-bpm'), style: text.displayLarge),
            Text('denyut per menit', style: text.bodyMedium),
            const SizedBox(height: 12),
            Chip(
              label: Text(status.label),
              labelStyle: const TextStyle(color: Colors.white),
              backgroundColor: statusColor(status),
              side: BorderSide.none,
            ),
            Text('Rentang umum saat istirahat: 60-100', style: text.bodySmall),
            const SizedBox(height: 8),
            Text(formatWaktu(reading.measuredAt), style: text.bodySmall),
            if (reading.note.isNotEmpty) Text(reading.note, style: text.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _ReadingTile extends StatelessWidget {
  const _ReadingTile({required this.reading});

  final HeartReading reading;

  @override
  Widget build(BuildContext context) {
    final status = HeartRateRules.statusOf(reading.bpm);
    final note = reading.note.isEmpty ? '' : ' · ${reading.note}';
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: statusColor(status),
        foregroundColor: Colors.white,
        child: Text('${reading.bpm}'),
      ),
      title: Text(status.label),
      subtitle: Text('${formatWaktu(reading.measuredAt)}$note'),
    );
  }
}
