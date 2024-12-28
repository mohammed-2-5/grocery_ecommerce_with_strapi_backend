import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:grocery_ecommerce/core/services/local_services/local_services.dart';
import 'package:grocery_ecommerce/core/services/remote_services/category_services.dart';

import '../model/category_model.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find();
  RxList<CategoryModel> categoryList =
      List<CategoryModel>.empty(growable: true).obs;
  LocalServices localServices = LocalServices();

  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    await localServices.init();

    getCategories();
    super.onInit();
  }

  void getCategories() async {
    try {
      isLoading.value = true;
      if (localServices.getCategoryList().isNotEmpty) {
        categoryList.assignAll(localServices.getCategoryList());
      }
      var response = await CategoryServices().getCategories();
      if (response.statusCode == 200) {
        categoryList.assignAll(categoryListFromJson(response.data));
        localServices.assignCategoriesList(
            categoryList: categoryListFromJson(response.data));
      } else {
        if (kDebugMode) {
          print("Error: ${response.statusCode}");
        }
      }

    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
