import 'package:get/get.dart';

import '../modules/groups_list/bindings/groups_list_binding.dart';
import '../modules/groups_list/views/groups_list_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GROUPS_LIST,
      page: () => const GroupsListView(),
      binding: GroupsListBinding(),
    ),
  ];
}
