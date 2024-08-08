import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/utils/api.dart';

import '../services/dio_interceptor.dart';
import '../services/token_manager.dart';

enum ApiStatus { ideal, loading, success, failed }

class ApiCallProvider extends ChangeNotifier {
  ApiStatus? status = ApiStatus.ideal;
  late Dio _dio;
  static ApiCallProvider instance = ApiCallProvider();

  ApiCallProvider() {
    final tokenManager = TokenManager();
    _dio = Dio();
    _dio.interceptors.add(DioTokenInterceptor(tokenManager, API.generateToken));

    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
  }

  Future<dynamic> getRequest(String endpoint) async {
    status = ApiStatus.loading;
    notifyListeners();
    debugPrint('API [GET] : $endpoint');
    try {
      Response response = await _dio.get(
        endpoint,
      );
      debugPrint('Response : ${jsonDecode(response.data)}');
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return jsonDecode(response.data);
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      notifyListeners();
      return ('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      return (e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return 'Unable to process request';
  }

  Future<dynamic> postRequest(
      String endpoint, Map<String, dynamic> requestBody) async {
    status = ApiStatus.loading;
    notifyListeners();
    debugPrint('API [POST]: $endpoint');
    debugPrint('Request : ${jsonEncode(requestBody)}');
    try {
      Response response = await _dio.post(
        endpoint,
        data: FormData.fromMap(requestBody),
      );
      debugPrint('Response : ${jsonDecode(response.data)}');
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return jsonDecode(response.data);
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      notifyListeners();
      debugPrint(e.toString());
      return ('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      debugPrint(e.toString());
      return (e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return 'Unable to process request';
  }
}
