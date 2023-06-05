import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService({required String baseUrl}) {
    _instance._dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
    );
    return _instance;
  }

  ApiService._internal() : _dio = Dio();
  final Dio _dio;
  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } catch (error) {
      throw handleError(error);
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.post(path, data: data);
      return response.data;
    } catch (error) {
      throw handleError(error);
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.put(path, data: data);
      return response.data;
    } catch (error) {
      throw handleError(error);
    }
  }

  dynamic handleError(error) {
    if (error is DioError) {
      // Dio 错误处理
      String errorMessage = '请求失败';
      if (error.response != null && error.response?.data != null) {
        errorMessage = error.response!.data.toString();
      }
      // 在这里可以根据实际需求进行错误提示或其他处理
      print(errorMessage);
      throw errorMessage;
    } else {
      // 其他错误处理
      throw error.toString();
    }
  }
}
