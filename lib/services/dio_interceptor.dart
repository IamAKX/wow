import 'package:dio/dio.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'token_manager.dart';

class DioTokenInterceptor extends Interceptor {
  final TokenManager _tokenManager;
  final Dio _dio;
  final String _refreshTokenUrl;

  DioTokenInterceptor(this._tokenManager, this._dio, this._refreshTokenUrl);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (await _tokenManager.isTokenExpired()) {
      await _refreshToken();
    }

    final token = await _tokenManager.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  Future<void> _refreshToken() async {
    String userId = prefs.getString(PrefsKey.userId) ?? '';
    final response = await _dio.post(
      _refreshTokenUrl,
      data: FormData.fromMap({'userId': userId}),
    );
    final newToken = response.data['token'];

    await _tokenManager.saveToken(newToken);
  }
}
