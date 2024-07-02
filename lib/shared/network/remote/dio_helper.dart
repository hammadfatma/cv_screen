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

  Future<List<dynamic>> getUsers() async {
    var response = await _dio.get('$_baseUrl/users');
    return response.data;
  }

  Future<List<dynamic>> getCartsByUserId(int? userId) async {
    var response = await _dio.get('$_baseUrl/carts/user/$userId');
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

  Future<Map<String, dynamic>?> loginUser(
      String userName, String password) async {
    var response = await _dio.post(
      '$_baseUrl/auth/login',
      data: {
        'username': userName,
        'password': password,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }
}
