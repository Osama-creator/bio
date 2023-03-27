import 'package:get/get.dart';

import '../../../data/models/group_model.dart';

class MonthlyReportController extends GetxController {
  final args = Get.arguments as Group;
  double getStudentPrice() {
    double price = 0;
    for (var student in args.students!) {
      price += student.price!;
    }
    return price;
  }

  double getStudentDis() {
    double price = 0;
    for (var student in args.students!) {
      price += (student.price! / int.parse(args.sessions!) * student.absence)
          .toInt();
    }
    return price;
  }
}
