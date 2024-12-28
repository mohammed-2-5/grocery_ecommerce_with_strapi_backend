import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_ecommerce/component/main_appbar.dart';
import 'package:grocery_ecommerce/controller/home_controller.dart';
import 'package:grocery_ecommerce/view/HomeView/widgets/banner/carusal_loading.dart';
import 'package:grocery_ecommerce/view/HomeView/widgets/banner/carusal_slider_view.dart';
import 'package:grocery_ecommerce/view/HomeView/widgets/popular_category/popular_category.dart';
import 'package:grocery_ecommerce/view/HomeView/widgets/popular_category/popular_category_loading.dart';
import 'package:grocery_ecommerce/view/HomeView/widgets/popular_product/popular_product.dart';
import 'package:grocery_ecommerce/view/HomeView/widgets/section_title.dart';

import '../../controller/controller.dart';
import 'widgets/popular_product/popular_product_loading.dart';

class HomeView extends StatelessWidget {
   HomeView({super.key, });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          MainAppbar(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Obx(() {
                    if (homeController.bannerList.isNotEmpty) {
                      return CarouselSliderView(
                          bannerList: homeController.bannerList);
                    } else {
                      return const CarouselLoading();
                    }
                  }),
                  const SectionTitle(title: "Popular Category"),
                  Obx(() {
                    if (homeController.popularCategoryList.isNotEmpty) {
                      return PopularCategory(
                          categories: homeController.popularCategoryList);
                    } else {
                      return const PopularCategoryLoading();
                    }
                  }),
                  const SectionTitle(title: "Popular Product"),
                  Obx(() {
                    if (homeController.popularProductList.isNotEmpty) {

                      return PopularProduct(
                          popularProducts: homeController.popularProductList);
                    } else {
                      return const PopularProductLoading();
                    }
                  }),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
