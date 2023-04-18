import 'package:get/get.dart';

import '../modules/create_exam/bindings/create_exam_binding.dart';
import '../modules/create_exam/views/create_exam_view.dart';
import '../modules/create_group/bindings/create_group_binding.dart';
import '../modules/create_group/views/create_group_view.dart';
import '../modules/create_session/bindings/create_session_binding.dart';
import '../modules/create_session/views/create_session_view.dart';
import '../modules/exam_details/bindings/exam_details_binding.dart';
import '../modules/exam_details/views/exam_details_view.dart';
import '../modules/exams_page/bindings/exams_page_binding.dart';
import '../modules/exams_page/views/exams_page_view.dart';
import '../modules/grades_list/bindings/grades_list_binding.dart';
import '../modules/grades_list/views/grades_list_view.dart';
import '../modules/groups_list/bindings/groups_list_binding.dart';
import '../modules/groups_list/views/groups_list_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/monthly_report/bindings/monthly_report_binding.dart';
import '../modules/monthly_report/views/monthly_report_view.dart';
import '../modules/show_gruop_details/bindings/show_gruop_details_binding.dart';
import '../modules/show_gruop_details/views/show_gruop_details_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/student_exam/bindings/student_exam_binding.dart';
import '../modules/student_exam/views/student_exam_view.dart';
import '../modules/student_exam_preview/bindings/student_exam_preview_binding.dart';
import '../modules/student_exam_preview/views/student_exam_preview_view.dart';
import '../modules/student_exams_list/bindings/student_exams_list_binding.dart';
import '../modules/student_exams_list/views/student_exams_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_IN;

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
    GetPage(
      name: _Paths.CREATE_SESSION,
      page: () => const CreateSessionView(),
      binding: CreateSessionBinding(),
    ),
    GetPage(
      name: _Paths.MONTHLY_REPORT,
      page: () => const MonthlyReportView(),
      binding: MonthlyReportBinding(),
    ),
    GetPage(
      name: _Paths.GRADES_LIST,
      page: () => const GradesListView(),
      binding: GradesListBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_EXAM,
      page: () => const CreateExamView(),
      binding: CreateExamBinding(),
    ),
    GetPage(
      name: _Paths.EXAMS_PAGE,
      page: () => const ExamsPageView(),
      binding: ExamsPageBinding(),
    ),
    GetPage(
      name: _Paths.EXAM_DETAILS,
      page: () => const ExamDetailsView(),
      binding: ExamDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_EXAMS_LIST,
      page: () => const StudentExamsListView(),
      binding: StudentExamsListBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_EXAM,
      page: () => const StudentExamView(),
      binding: StudentExamBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_EXAM_PREVIEW,
      page: () => const StudentExamPreviewView(),
      binding: StudentExamPreviewBinding(),
    ),
  ];
}
