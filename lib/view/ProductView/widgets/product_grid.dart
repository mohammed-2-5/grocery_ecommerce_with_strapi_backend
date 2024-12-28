
import 'package:flutter/material.dart';
import 'package:grocery_ecommerce/model/product_model.dart';
import 'package:grocery_ecommerce/view/ProductView/widgets/product_card.dart';


class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2/3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
      ),
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCard(product: products[index]),
    );
  }
}
