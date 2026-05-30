// core/lib/core.dart

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

export 'network.dart';
export 'storage.dart';

import 'network.dart';
import 'storage.dart';

// ─────────────────────────────────────
// نقطة الدخول الوحيدة للـ core
// ─────────────────────────────────────

final getIt = GetIt.instance;

Future<void> initCore() async {
  // Storage
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<StorageService>(StorageService(prefs));

  // Network
  getIt.registerSingleton<NetworkInfo>(NetworkInfo(Connectivity()));

  getIt.registerSingleton<ApiClient>(
    ApiClient(storage: getIt<StorageService>()),
  );
}
