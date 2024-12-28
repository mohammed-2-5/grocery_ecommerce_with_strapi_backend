import 'package:dio/dio.dart';
import '../../const.dart';
import 'api_services.dart';

class AuthServices extends ApiServices {
  Future<Response> signUp({required String email, required String password}) async {
    try {
      final response = await dio.post(
        '/api/auth/local/register',
        data: {"username": email, "email": email, "password": password},
        options: Options(headers: {"Content-Type": "application/json"}),
      );
      return response; // Return the response object
    } catch (e) {
      throw Exception('Error during sign-up: $e');
    }
  }

  Future<dynamic> signIn({required String email, required String password}) async {
    try {
      var body = {"identifier": email, "password": password};
      return await dio.post('/api/auth/local', data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getProfile({required String token}) async {
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      return await dio.get('/api/profile/me');
    } catch (e) {
      rethrow;
    }
  }
  Future<Response> createProfile({required String fullName, required String token}) async {
    final body = {"FullName": fullName};
    final response = await dio.post(
      '$apiUrl/api/profile/me',
      data: body,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );
    return response;
  }
}
