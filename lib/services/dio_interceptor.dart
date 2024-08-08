import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'token_manager.dart';

class DioTokenInterceptor extends Interceptor {
  final TokenManager _tokenManager;

  final String _refreshTokenUrl;

  DioTokenInterceptor(this._tokenManager, this._refreshTokenUrl);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (await _tokenManager.isTokenExpired()) {
      await _refreshToken();
    }

    final token = await _tokenManager.getToken();
    if (token != null) {
      options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
      options.headers['Authorization'] = token;
      options.contentType = Headers.formUrlEncodedContentType;
    }

    return super.onRequest(options, handler);
  }

  Future<void> _refreshToken() async {
    final Dio dio = Dio();
    String userId = prefs.getString(PrefsKey.userId) ?? '41';
    log('Fetching token for userId=$userId from $_refreshTokenUrl');
    final response = await dio.post(
      _refreshTokenUrl,
      data: FormData.fromMap({'userId': userId}),
    );
    log('Response : ${response.data}');
    final newToken = response.data['token'];
    log('Token : $newToken');
    await _tokenManager.saveToken(newToken);
  }
}
