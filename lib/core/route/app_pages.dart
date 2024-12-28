import 'package:get/get.dart';
import 'package:grocery_ecommerce/core/Bindings/dashboard_bindings.dart';
import 'package:grocery_ecommerce/core/route/app_route.dart';
import 'package:grocery_ecommerce/view/DashboardView/dashboard_view.dart';

class AppPages{
  static var list = [
    GetPage(name: AppRoute.dashboard, page: () => const DashboardView(),
    binding: DashboardBindings()


    ),];
}