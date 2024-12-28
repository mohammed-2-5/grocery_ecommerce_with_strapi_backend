import 'package:flutter/material.dart';
import 'package:grocery_ecommerce/model/category_model.dart';

import 'popular_category_card.dart';



class PopularCategory extends StatelessWidget {
  final List<CategoryModel> categories;
  const PopularCategory({super.key,
    required this.categories
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) => PopularCategoryCard(
              categoryModel: categories[index]
          )
      ),
    );
  }
}