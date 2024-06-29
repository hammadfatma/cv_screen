import 'package:cvscreen/models/user/user.dart';
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

  Future<Map<String, dynamic>> addUser(User userModel) async {
    var response = await _dio.post(
      '$_baseUrl/users',
      data: {
        'email': userModel.email,
        'phone': userModel.phone,
        'username': userModel.username,
        'password': userModel.password,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getUser(String userId) async {
    var response = await _dio.get('$_baseUrl/users/$userId');
    return response.data;
  }
}
