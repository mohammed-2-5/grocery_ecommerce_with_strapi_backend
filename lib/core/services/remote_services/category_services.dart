import 'api_services.dart';

class CategoryServices extends ApiServices {
  Future<dynamic> getCategories() async {
    try {
      final response = await dio.get(
        '/api/categories',
        queryParameters: {
          'populate': 'image', // Populate the image field
        },
      );
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
  Future<dynamic> getPopularCategories() async {
    try {
      // Make the GET request with Dio
      final response = await dio.get(
        '/api/popular-categories',
        queryParameters: {
          'populate': 'category.image',
          'pagination[start]': 0,
          'pagination[limit]': 4,
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        return response;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
