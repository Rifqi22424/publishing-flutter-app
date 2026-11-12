import 'package:flutter/material.dart';

import '../../domain/heart_rate_rules.dart';

/// Hasil formulir yang dikirim kembali dengan Navigator.pop().
typedef NewReading = ({int bpm, String note});

/// Formulir catat detak jantung. Waktu pengukuran = saat tombol Simpan ditekan.
class AddReadingScreen extends StatefulWidget {
  const AddReadingScreen({super.key});

  @override
  State<AddReadingScreen> createState() => _AddReadingScreenState();
}

class _AddReadingScreenState extends State<AddReadingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bpm = TextEditingController();
  final _note = TextEditingController();

  @override
  void dispose() {
    _bpm.dispose();
    _note.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final NewReading result = (bpm: int.parse(_bpm.text.trim()), note: _note.text);
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catat Detak Jantung')),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Duduk tenang 5 menit, lalu hitung denyut nadi di pergelangan tangan selama 60 detik.'),
            const SizedBox(height: 20),
            TextFormField(
              key: const Key('field-bpm'),
              controller: _bpm,
              decoration: const InputDecoration(
                labelText: 'Detak jantung',
                suffixText: 'bpm',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: HeartRateRules.validateBpm,
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('field-catatan'),
              controller: _note,
              decoration: const InputDecoration(
                labelText: 'Catatan (boleh kosong)',
                hintText: 'Contoh: setelah bangun tidur',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            FilledButton(
              key: const Key('tombol-simpan'),
              onPressed: _save,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
