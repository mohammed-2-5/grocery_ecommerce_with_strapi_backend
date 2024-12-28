import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_ecommerce/core/services/remote_services/product_services.dart';
import 'package:grocery_ecommerce/model/product_model.dart';


class ProductController extends GetxController {

  static ProductController instance = Get.find();
  final TextEditingController searchTextEditController = TextEditingController();
  RxString searchVal = ''.obs;
  RxList<ProductModel> productList = List<ProductModel>.empty(growable: true)
      .obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    isLoading.value = true;
    var response = await ProductServices().getProducts();
    if (response.statusCode == 200) {
      productList.assignAll(productListFromJson(response.data));
    } else {
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
      }
    }
    isLoading.value = false;
  }

  void getProductsByName({required String name}) async {
    isLoading.value = true;
    var response = await ProductServices().getProductsByName(name);
    if (response.statusCode == 200) {
      productList.assignAll(productListFromJson(response.data));
      if (kDebugMode) {
        print("Success: ${response.data}");
      }
    } else {
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
      }
    }
    isLoading.value = false;
  }

  void getProductsByCategory({required int id}) async {
    isLoading.value = true;
    var response = await ProductServices().getProductsByCategory(id);
    if (response.statusCode == 200) {
      productList.assignAll(productListFromJson(response.data));
      if (kDebugMode) {
        print("Success: ${response.data}");
      }
    } else {
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
      }
    }
    isLoading.value = false;
  }
}