import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:grocery_ecommerce/controller/dashboard_controller.dart';
import 'package:grocery_ecommerce/view/AccountView/account_view.dart';
import 'package:grocery_ecommerce/view/CategoryView/category_view.dart';
import 'package:grocery_ecommerce/view/HomeView/home_view.dart';
import 'package:grocery_ecommerce/view/ProductView/product_view.dart';


class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomeView(),
                 ProductView(),
                const CategoryView(),
                const AccountView()
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 0.7
                    )
                )
            ),
            child: SnakeNavigationBar.color(
              behaviour: SnakeBarBehaviour.floating,
              snakeShape: SnakeShape.circle,
              padding: const EdgeInsets.symmetric(vertical: 5),
              unselectedLabelStyle: const TextStyle(fontSize: 11),
              snakeViewColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).colorScheme.secondary,
              showUnselectedLabels: true,
              currentIndex: controller.tabIndex,
              onTap: (val){
                controller.updateIndex(val);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
                BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account')
              ],
            ),
          ),
        );
      }
    );

  }
}
