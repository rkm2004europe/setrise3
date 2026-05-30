// core/lib/network.dart

import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'storage.dart';

// ─────────────────────────────────────
// 1. فحص الإنترنت
// ─────────────────────────────────────

class NetworkInfo {
  final Connectivity _connectivity;
  NetworkInfo(this._connectivity);

  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}

// ─────────────────────────────────────
// 2. إعداد الـ HTTP
// ─────────────────────────────────────

class ApiClient {
  late final Dio _dio;

  ApiClient({required StorageService storage}) {
    _dio = Dio(
      BaseOptions(
        baseUrl:        'https://api.setrise.com/api/v1',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept':       'application/json',
        },
      ),
    );

    // ✅ يضيف التوكن تلقائياً في كل request
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.get('access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (err, handler) {
          handler.next(err);
        },
      ),
    );
  }

  // GET
  Future<dynamic> get(String path, {Map<String, dynamic>? params}) async {
    try {
      final res = await _dio.get(path, queryParameters: params);
      return res.data;
    } on DioException catch (e) {
      throw _error(e);
    }
  }

  // POST
  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final res = await _dio.post(path, data: data);
      return res.data;
    } on DioException catch (e) {
      throw _error(e);
    }
  }

  // PUT
  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final res = await _dio.put(path, data: data);
      return res.data;
    } on DioException catch (e) {
      throw _error(e);
    }
  }

  // DELETE
  Future<dynamic> delete(String path) async {
    try {
      final res = await _dio.delete(path);
      return res.data;
    } on DioException catch (e) {
      throw _error(e);
    }
  }

  // ─── تحويل الأخطاء ───
  Exception _error(DioException e) {
    final code    = e.response?.statusCode;
    final message = e.response?.data?['message'] ?? 'خطأ';

    if (e.type == DioExceptionType.connectionTimeout) {
      return Exception('لا يوجد اتصال');
    }
    if (code == 401) return Exception('يرجى تسجيل الدخول');
    if (code == 404) return Exception('غير موجود');
    return Exception(message);
  }
}
