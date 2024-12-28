import 'package:get/get.dart';
import 'package:grocery_ecommerce/controller/auth_controller.dart';
import 'package:grocery_ecommerce/controller/category_controller.dart';
import 'package:grocery_ecommerce/controller/home_controller.dart';
import 'package:grocery_ecommerce/controller/product_controller.dart';

import '../../../controller/dashboard_controller.dart';

class DashboardBindings extends Bindings
{
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(ProductController());
    Get.put(CategoryController());
    Get.put(AuthController());

  }
}