import 'package:get/get.dart';

import '../../../data/models/months_model.dart';

class PreviousMonthsDetailsController extends GetxController {
  final args = Get.arguments as GroupPreviousMonths;
  double getStudentPrice() {
    double price = 0;
    for (var student in args.students!) {
      price += student.price!;
    }

    return (price / args.sessions!) * args.sessions!;
  }

  double getPriceBeforeDiscount() {
    double price = 0;
    for (var student in args.students!) {
      price += student.price!;
    }

    return price;
  }

  double getStudentDis() {
    double price = 0;
    for (var student in args.students!) {
      price += (student.price! / args.sessions! * student.absence).toInt();
    }
    return price;
  }

  double getPriceAfterDiscount() {
    double price = 0;
    for (var student in args.students!) {
      price += student.price!;
    }

    return price - getStudentDis();
  }

  int totalAfterdiscount(int index) {
    return (args.students![index].price! /
            args.sessions! *
            args.students![index].absence)
        .toInt();
  }
}
