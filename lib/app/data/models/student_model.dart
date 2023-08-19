// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Studen {
  final String name;
  final String id;
  bool? isPaid;
  int absence;
  int? price;

  Studen(
      {required this.name,
      required this.id,
      required this.absence,
      this.price,
      this.isPaid});
  Map<String, dynamic> toJson() {
    return {'name': name, 'id': id, 'absence': absence, 'price': price};
  }
}

class Student extends Equatable {
  String name;
  String grade;
  String gradeId;
  String email;
  String password;
  bool isConfirmed;

  Student({
    required this.name,
    required this.grade,
    required this.gradeId,
    required this.password,
    required this.email,
    this.isConfirmed = false,
  });

  @override
  List<Object?> get props => [name, grade, password, isConfirmed];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'grade': grade,
      'password': password,
      'grade_id': gradeId,
      'email': email,
      'confirmed': isConfirmed,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      grade: json['grade'],
      password: json['password'],
      isConfirmed: json['confirmed'],
      email: json["email"],
      gradeId: json["grade_id"],
    );
  }
}
