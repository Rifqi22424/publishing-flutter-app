import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sesi15_publikasi_aplikasi/ui/add_reading/add_reading_screen.dart';

void main() {
  testWidgets('Simpan dengan isian kosong menampilkan pesan error', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddReadingScreen()));

    await tester.tap(find.byKey(const Key('tombol-simpan')));
    await tester.pump();

    expect(find.text('Detak jantung harus berupa angka'), findsOneWidget);
  });

  testWidgets('BPM 250 ditolak', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddReadingScreen()));

    await tester.enterText(find.byKey(const Key('field-bpm')), '250');
    await tester.tap(find.byKey(const Key('tombol-simpan')));
    await tester.pump();

    expect(find.text('Masukkan angka antara 30 dan 220'), findsOneWidget);
  });
}
