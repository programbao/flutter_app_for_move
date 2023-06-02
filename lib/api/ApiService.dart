import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }
  ApiService._internal()
      : _dio = Dio(BaseOptions(
          connectTimeout: const Duration(milliseconds: 5000), // 设置连接超时时间
          receiveTimeout: const Duration(milliseconds: 5000), // 设置接收超时时间
        ));

  final Dio _dio;
  // ApiService() {
  //   BaseOptions options = BaseOptions(
  //     baseUrl: 'https://example.com/api', // 设置你的接口基础 URL
  //     connectTimeout: 5000, // 设置连接超时时间
  //     receiveTimeout: 5000, // 设置接收超时时间
  //   );
  //   _dio = Dio(options);
  // }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (error) {
      throw handleError(error);
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.post(path, data: data);
      return response;
    } catch (error) {
      throw handleError(error);
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.put(path, data: data);
      return response;
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
