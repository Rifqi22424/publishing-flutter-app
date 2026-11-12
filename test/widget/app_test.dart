import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sesi15_publikasi_aplikasi/app.dart';
import 'package:sesi15_publikasi_aplikasi/config/dependencies.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty();
    PackageInfo.setMockInitialValues(
      appName: 'NusaJantung',
      packageName: 'id.ac.nusaputra.nusajantung',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
  });

  Widget app() => MultiProvider(providers: providers, child: const NusaJantungApp());

  testWidgets('layar utama selalu menampilkan peringatan bukan alat medis', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('Bukan alat medis'), findsOneWidget);
    expect(find.textContaining('Belum ada catatan'), findsOneWidget);
  });

  testWidgets('mencatat 72 bpm menampilkan status Normal', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('tombol-catat')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('field-bpm')), '72');
    await tester.tap(find.byKey(const Key('tombol-simpan')));
    await tester.pumpAndSettle();

    expect(find.text('72'), findsOneWidget);
    expect(find.text('Normal'), findsOneWidget);
  });

  testWidgets('layar Tentang menampilkan versi dari pubspec', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('tombol-tentang')));
    await tester.pumpAndSettle();

    expect(find.text('Versi 1.0.0 (build 1)'), findsOneWidget);
  });
}
