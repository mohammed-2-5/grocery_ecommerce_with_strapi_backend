import 'package:dio/dio.dart';
import '../../const.dart';

class ApiServices {
  final Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
      )
  );
}
