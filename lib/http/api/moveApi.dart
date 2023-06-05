import 'package:dio/src/response.dart';

import '../request.dart';
import '../../config/Config.dart';

class MovieApi {
  static var BASE_URL = Config.baseApi;
  final ApiService apiService = ApiService(baseUrl: BASE_URL);

  // 获取电影
  Future<Map<String, dynamic>> getMovie(
      {Map<String, dynamic>? queryParameters}) async {
    var result =
        await apiService.get('/movie/page', queryParameters: queryParameters);
    return result;
  }
}
