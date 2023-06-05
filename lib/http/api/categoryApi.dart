import 'package:dio/src/response.dart';

import '../request.dart';
import '../../config/Config.dart';

class CategoryApi {
  static var BASE_URL = Config.baseApi;
  final ApiService apiService = ApiService(baseUrl: BASE_URL);

  // 获取电影
  Future<Map<String, dynamic>> getCategory(
      {Map<String, dynamic>? queryParameters}) async {
    var result = await apiService.get('/category/list/findByMovieOrTv',
        queryParameters: queryParameters);
    return result;
  }
}
