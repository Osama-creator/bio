import 'package:get/get.dart';

import '../../../data/models/group_model.dart';

class MonthlyReportController extends GetxController {
  final args = Get.arguments as Group;
  double getStudentPrice() {
    double price = 0;
    for (var student in args.students!) {
      price += student.price!;
    }

    return (price / int.tryParse(args.sessions!)!) * args.currentSession!;
  }

  double getStudentDis() {
    double price = 0;
    for (var student in args.students!) {
      price += (student.price! / int.parse(args.sessions!) * student.absence)
          .toInt();
    }
    return price;
  }

  int totalAfterdiscount(int index) {
    return (args.students![index].price! /
            int.parse(args.sessions!) *
            args.students![index].absence)
        .toInt();
  }
}
