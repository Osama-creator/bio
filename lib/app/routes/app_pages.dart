import 'package:get/get.dart';

import '../modules/create_exam/bindings/create_exam_binding.dart';
import '../modules/create_exam/views/create_exam_view.dart';
import '../modules/create_group/bindings/create_group_binding.dart';
import '../modules/create_group/views/create_group_view.dart';
import '../modules/create_session/bindings/create_session_binding.dart';
import '../modules/create_session/views/create_session_view.dart';
import '../modules/edit_group/bindings/edit_group_binding.dart';
import '../modules/edit_group/views/edit_group_view.dart';
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
import '../modules/previous_months/bindings/previous_months_binding.dart';
import '../modules/previous_months/views/previous_months_view.dart';
import '../modules/previous_months_details/bindings/previous_months_details_binding.dart';
import '../modules/previous_months_details/views/previous_months_details_view.dart';
import '../modules/show_gruop_details/bindings/show_gruop_details_binding.dart';
import '../modules/show_gruop_details/views/show_gruop_details_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/student_exam/bindings/student_exam_binding.dart';
import '../modules/student_exam/views/student_exam_view.dart';
import '../modules/student_exam_preview/bindings/student_exam_preview_binding.dart';
import '../modules/student_exam_preview/views/student_exam_preview_view.dart';
import '../modules/student_markes/bindings/student_markes_binding.dart';
import '../modules/student_markes/views/student_markes_view.dart';
import '../modules/student_markes_for_teacher/bindings/student_markes_for_teacher_binding.dart';
import '../modules/student_markes_for_teacher/views/student_markes_for_teacher_view.dart';
import '../modules/students_accounts/bindings/students_accounts_binding.dart';
import '../modules/students_accounts/views/students_accounts_view.dart';
import '../modules/students_league/bindings/students_league_binding.dart';
import '../modules/students_league/views/students_league_view.dart';
import '../modules/teacher_home/bindings/teacher_home_binding.dart';
import '../modules/teacher_home/views/teacher_home_view.dart';
import '../modules/video_page/bindings/video_page_binding.dart';
import '../modules/video_page/views/video_page_view.dart';
import '../modules/videos_page/bindings/videos_page_binding.dart';
import '../modules/videos_page/views/videos_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

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
      name: _Paths.STUDENT_EXAM,
      page: () => const StudentExamView(),
      binding: StudentExamBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_EXAM_PREVIEW,
      page: () => const StudentExamPreviewView(),
      binding: StudentExamPreviewBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_MARKES,
      page: () => const StudentMarkesView(),
      binding: StudentMarkesBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_MARKES_FOR_TEACHER,
      page: () => const StudentMarkesForTeacherView(),
      binding: StudentMarkesForTeacherBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_HOME,
      page: () => const TeacherHomeView(),
      binding: TeacherHomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_GROUP,
      page: () => const EditGroupView(),
      binding: EditGroupBinding(),
    ),
    GetPage(
      name: _Paths.PREVIOUS_MONTHS,
      page: () => const PreviousMonthsView(),
      binding: PreviousMonthsBinding(),
    ),
    GetPage(
      name: _Paths.PREVIOUS_MONTHS_DETAILS,
      page: () => const PreviousMonthsDetailsView(),
      binding: PreviousMonthsDetailsBinding(),
    ),
    GetPage(
      name: _Paths.STUDENTS_ACCOUNTS,
      page: () => StudentsAccountsView(),
      binding: StudentsAccountsBinding(),
    ),
    GetPage(
      name: _Paths.STUDENTS_LEAGUE,
      page: () => const StudentsLeagueView(),
      binding: StudentsLeagueBinding(),
    ),
    GetPage(
      name: _Paths.VIDEOS_PAGE,
      page: () => const VideosPageView(),
      binding: VideosPageBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_PAGE,
      page: () => const VideoPageView(),
      binding: VideoPageBinding(),
    ),
  ];
}
