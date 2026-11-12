import 'package:flutter/material.dart';

import '../../domain/heart_rate_rules.dart';

/// Warna untuk setiap status detak jantung.
Color statusColor(HeartStatus status) => switch (status) {
      HeartStatus.rendah => const Color(0xFF2457C5),
      HeartStatus.normal => const Color(0xFF0E7C66),
      HeartStatus.tinggi => const Color(0xFFB7591F),
    };
