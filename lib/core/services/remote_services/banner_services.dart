import 'api_services.dart';

class BannerServices extends ApiServices {
  Future<dynamic> getBanners() async {
    try {
      final response = await dio.get('/api/banners?populate=image');
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
