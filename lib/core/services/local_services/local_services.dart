import 'package:grocery_ecommerce/model/banner_model.dart';
import 'package:grocery_ecommerce/model/product_model.dart';
import 'package:hive/hive.dart';

import '../../../model/category_model.dart';
import '../../../model/user_model.dart';

class LocalServices {
  late Box<BannerModel> bannerModelBox;
  late Box<CategoryModel> categoryModelBox;
  late Box<CategoryModel> popularCategoryModelBox;

  late Box<ProductModel>productModelBox;
late Box<String> tokenBox;
late Box<User> userBox;
  Future<void> init() async {
    bannerModelBox = await Hive.openBox<BannerModel>('Banners');
    categoryModelBox = await Hive.openBox<CategoryModel>('Categories');
    popularCategoryModelBox = await Hive.openBox<CategoryModel>('PopularCategories');
   productModelBox = await Hive.openBox<ProductModel>('Products');
    tokenBox = await Hive.openBox<String>('Token');
    userBox = await Hive.openBox<User>('User');



  }

  Future<void> addToken({required String token}) async {

    await tokenBox.put('Token', token);
  }
  Future<void> addUser({required User user}) async {
    await userBox.put('User', user);
  }

  Future<void> clear() async {
    await tokenBox.clear();
    await userBox.clear();
  }

  String? getToken() => tokenBox.get('Token');
  User? getUser() => userBox.get('User');
  Future<void> assignBannerList({required List<BannerModel> bannerList}) async {
    await bannerModelBox.clear();
    await bannerModelBox.addAll(bannerList);
  }

  List<BannerModel> getBannerList() => bannerModelBox.values.toList();



  Future<void> assignPopularCategoriesList({required List<CategoryModel> popularCategoryList}) async {
    await popularCategoryModelBox.clear();
    await popularCategoryModelBox.addAll(popularCategoryList);
  }
  List<CategoryModel> getPopularCategoryList() => popularCategoryModelBox.values.toList();

  Future<void> assignCategoriesList({required List<CategoryModel> categoryList}) async {
    await categoryModelBox.clear();
    await categoryModelBox.addAll(categoryList);
  }

  List<CategoryModel> getCategoryList() => categoryModelBox.values.toList();


  Future<void> assignProductList({required List<ProductModel> productList}) async {
    await productModelBox.clear();
    await productModelBox.addAll(productList);
  }

  List<ProductModel> getProductList() => productModelBox.values.toList();
}
