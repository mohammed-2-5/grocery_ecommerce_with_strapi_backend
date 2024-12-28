import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_ecommerce/component/main_appbar.dart';
import 'package:grocery_ecommerce/view/ProductView/widgets/product_grid.dart';
import 'package:grocery_ecommerce/view/ProductView/widgets/product_loading_grid.dart';

import '../../controller/controller.dart';

class ProductView extends StatelessWidget {
   const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
           MainAppbar(),
          Expanded(
              child: Obx((){
                if(productController.isLoading.value){
                  return const ProductLoadingGrid();
                } else {
                  if(productController.productList.isNotEmpty){
                    return ProductGrid(products: productController.productList);
                  } else {
                    return Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/not_found.jpg'),
                          const SizedBox(height: 10),
                          const Text('Products Not Found!',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    );
                  }
                }
              })
          )
        ],
      ),
    );
  }
}