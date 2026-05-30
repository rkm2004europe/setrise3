// core/lib/storage.dart

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;
  StorageService(this._prefs);

  // حفظ
  Future<void> set(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // جلب
  Future<String?> get(String key) async {
    return _prefs.getString(key);
  }

  // حذف
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // مسح الكل
  Future<void> clear() async {
    await _prefs.clear();
  }

  // ─── مفاتيح ثابتة ───
  static const String tokenKey   = 'access_token';
  static const String userKey    = 'current_user';
  static const String loggedIn   = 'is_logged_in';
}
