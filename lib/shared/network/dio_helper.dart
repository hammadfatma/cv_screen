import 'package:dio/dio.dart';

class DioHelper {
  final String _baseUrl = 'https://fakestoreapi.com';
  final Dio _dio;
  DioHelper(this._dio);
  Future<List<dynamic>> getProducts() async {
    var response = await _dio.get('$_baseUrl/products');
    return response.data;
  }

  Future<List<dynamic>> getProductsByCategory(String categoryName) async {
    var response = await _dio.get('$_baseUrl/products/category/$categoryName');
    return response.data;
  }
}
