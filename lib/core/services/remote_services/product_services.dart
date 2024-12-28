import 'package:dio/dio.dart';
import 'api_services.dart';

class ProductServices extends ApiServices {
  Future<dynamic> getPopularProducts() async {
    try {
      // Make the GET request with Dio
      final response = await dio.get(
        '/api/popular-products',
        queryParameters: {
          'populate': 'product.images',
          'pagination[start]': 0,
          'pagination[limit]': 4,
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        return response;
      } else {
        print("Error++++++: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error++++: $e");
      return null;
    }
  }
  Future<dynamic> getProducts() async {
    try {
      // Make the GET request with Dio
      final response = await dio.get(
        '/api/products',
        queryParameters: {
          'populate[tags]': '*',       // Populate tags
          'populate[images]': '*',     // Populate images
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        return response;
      } else {
        print("Error++++++: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error++++: $e");
      return null;
    }
  }
  Future<dynamic> getProductsByName(String name) async {
    try {
      // Make the GET request with Dio
      final response = await dio.get(
        '/api/products',
        queryParameters: {
          'populate[tags]': '*',       // Populate tags
          'populate[images]': '*',
          'filters[name][\$contains]': name,// Populate images
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        return response;
      } else {
        print("Error++++++: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error++++: $e");
      return null;
    }
  }
  Future<dynamic> getProductsByCategory(int id) async {
    try {
      // Make the GET request with Dio
      final response = await dio.get(
        '/api/products',
        queryParameters: {
          'populate[tags]': '*',       // Populate tags
          'populate[images]': '*',
          'filters[category][id]': id,// Populate images
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        return response;
      } else {
        print("Error++++++: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error++++: $e");
      return null;
    }
  }

}
