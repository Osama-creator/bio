import 'package:get/get.dart';

import '../../../data/models/months_model.dart';

class PreviousMonthsDetailsController extends GetxController {
  final args = Get.arguments as GroupPreviousMonths;
  double getStudentPrice() {
    double price = 0;
    for (var student in args.students!) {
      price += student.price!;
    }

    return (price / args.sessions!);
  }

  double getStudentDis() {
    double price = 0;
    for (var student in args.students!) {
      price += (student.price! / args.sessions! * student.absence).toInt();
    }
    return price;
  }

  int totalAfterdiscount(int index) {
    return (args.students![index].price! /
            args.sessions! *
            args.students![index].absence)
        .toInt();
  }
}
