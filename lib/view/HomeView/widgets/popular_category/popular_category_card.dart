import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_ecommerce/core/const.dart';
import 'package:grocery_ecommerce/model/category_model.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../controller/controller.dart';

class PopularCategoryCard extends StatefulWidget {
  final CategoryModel categoryModel;
  const PopularCategoryCard({super.key,
    required this.categoryModel
  });

  @override
  State<PopularCategoryCard> createState() => _PopularCategoryCardState();
}

class _PopularCategoryCardState extends State<PopularCategoryCard> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: InkWell(
        onTap: () {
          setState(() {
            _selected = !_selected;
          });
          dashboardController.updateIndex(1);
          productController.searchTextEditController.text = 'cat: ${widget.categoryModel.name}';
          productController.searchVal.value = 'cat: ${widget.categoryModel.name}';
          productController.getProductsByCategory(id: widget.categoryModel.id);
        },
        child: CachedNetworkImage(
          imageUrl: apiUrl + widget.categoryModel.image,
          imageBuilder: (context, imageProvider) => Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 270,
              height: 140,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.categoryModel.name,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ),
          placeholder: (context, url) => Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                width: 270,
                height: 140,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 270,
              height: 140,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}