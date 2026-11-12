import 'package:flutter/material.dart';

import 'ui/home/home_page.dart';

class NusaJantungApp extends StatelessWidget {
  const NusaJantungApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaJantung',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: const Color(0xFFC8323F)),
      home: const HomePage(),
    );
  }
}
