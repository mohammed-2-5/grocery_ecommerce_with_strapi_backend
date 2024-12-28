import 'package:get/get.dart';
import 'package:grocery_ecommerce/core/services/local_services/local_services.dart';
import 'package:grocery_ecommerce/core/services/remote_services/banner_services.dart';
import 'package:grocery_ecommerce/core/services/remote_services/category_services.dart';
import 'package:grocery_ecommerce/core/services/remote_services/product_services.dart';
import 'package:grocery_ecommerce/model/banner_model.dart';
import 'package:grocery_ecommerce/model/category_model.dart';
import 'package:grocery_ecommerce/model/product_model.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<BannerModel> bannerList = List<BannerModel>.empty(growable: true).obs;
  RxList<CategoryModel> popularCategoryList = List<CategoryModel>.empty(
      growable: true).obs;
  RxList<ProductModel> popularProductList = List<ProductModel>.empty(
      growable: true).obs;

  RxBool isLoading = false.obs;
  RxBool isPopularCategoryLoading = false.obs;
  RxBool isPopularProductLoading = false.obs;
  LocalServices localServices = LocalServices();

  @override
  void onInit() async{
    await localServices.init();
    getBanners();
    getPopularCategories();
    getPopularProducts();
    super.onInit();
  }

  void getBanners() async {
    try {
      isLoading.value = true;
      if (localServices.getBannerList().isNotEmpty) {
        bannerList.assignAll(localServices.getBannerList());
      }
      // Await the result of the API call
      var response = await BannerServices().getBanners();

      // Check if the response status is success (typically HTTP 200)
      if (response.statusCode == 200) {
        // Pass the response data as a string to dataModelListFromJson
        bannerList.assignAll(dataModelListFromJson(response.data));
        localServices.assignBannerList(bannerList: dataModelListFromJson(response.data));
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void getPopularCategories() async {
    try {
      isPopularCategoryLoading.value = true;
      if (localServices.getPopularCategoryList().isNotEmpty) {
        popularCategoryList.assignAll(localServices.getPopularCategoryList());
      }
      // Await the result of the API call
      var response = await CategoryServices().getPopularCategories();

      // Check if the response status is success (typically HTTP 200)
      if (response != null) {
        // Directly pass the parsed data map to the list function
        popularCategoryList.assignAll(
            popularCategoryListFromJson(response.data));
        localServices.assignPopularCategoriesList(popularCategoryList:popularCategoryListFromJson(response.data));


      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      print(popularCategoryList.first.name);
      isPopularCategoryLoading.value = false;
    }
  }


  void getPopularProducts() async {
    try {
      isPopularProductLoading.value = true;
      if (localServices.getProductList().isNotEmpty) {
        popularProductList.assignAll(localServices.getProductList());
      }
      // Await the result of the API call
      var response = await ProductServices().getPopularProducts();

      // Check if the response status is success (typically HTTP 200)
      if (response != null) {
        // Directly pass the parsed data map to the list function
        List<ProductModel> products = popularProductListFromJson(response.data);

        // Assign parsed data to the list
        popularProductList.assignAll(products);
        localServices.assignProductList(productList:products);

        print('success');
      } else {
        print("Error+++: ");
      }
    } catch (e) {
      print("Error++++++: $e");
    } finally {
      print(popularProductList.first.name);
      isPopularProductLoading.value = false;
    }
  }


}