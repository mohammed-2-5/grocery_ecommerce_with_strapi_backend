import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:grocery_ecommerce/core/route/app_pages.dart';
import 'package:grocery_ecommerce/core/route/app_route.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/theme/app_theme.dart';
import 'model/banner_model.dart';
import 'model/category_model.dart';
import 'model/product_model.dart';
import 'model/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BannerModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter( CategoryModelAdapter());
  Hive.registerAdapter( UserAdapter());

  runApp(const GroceryMain());
}

class GroceryMain extends StatelessWidget {
  const GroceryMain({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.list,
      initialRoute: AppRoute.dashboard,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      builder: EasyLoading.init(),
    );
  }
}

void configLoading(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}