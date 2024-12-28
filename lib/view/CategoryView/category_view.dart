import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import 'widgets/category_card.dart';


class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.categoryList.isNotEmpty) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: categoryController.categoryList.length,
          itemBuilder: (context, index) =>
              CategoryCard(categoryModel: categoryController.categoryList[index]),
        );
      } else {
        return Container();
      }
    });
  }
}