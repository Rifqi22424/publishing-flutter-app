import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repositories/reading_repository.dart';
import '../data/services/reading_storage.dart';

List<SingleChildWidget> get providers => [
      ChangeNotifierProvider(
        create: (context) =>
            ReadingRepository(storage: ReadingStorage(SharedPreferencesAsync()))..load(),
      ),
    ];
