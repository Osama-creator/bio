import 'package:get/get.dart';

import '../modules/create_group/bindings/create_group_binding.dart';
import '../modules/create_group/views/create_group_view.dart';
import '../modules/groups_list/bindings/groups_list_binding.dart';
import '../modules/groups_list/views/groups_list_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/show_gruop_details/bindings/show_gruop_details_binding.dart';
import '../modules/show_gruop_details/views/show_gruop_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.GROUPS_LIST;

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
    GetPage(
      name: _Paths.CREATE_GROUP,
      page: () => const CreateGroupView(),
      binding: CreateGroupBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_GRUOP_DETAILS,
      page: () => const ShowGruopDetailsView(),
      binding: ShowGruopDetailsBinding(),
    ),
  ];
}
