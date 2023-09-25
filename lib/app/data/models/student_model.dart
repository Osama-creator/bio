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
  int? marks;
  int? wPoints;
  bool isConfirmed;
  int rightAnswers;
  int wrongAnswers;
  int examCount;
  String nickname;

  Student({
    required this.name,
    required this.grade,
    required this.gradeId,
    required this.password,
    required this.email,
    this.marks,
    this.wPoints,
    this.isConfirmed = false,
    this.rightAnswers = 0,
    this.wrongAnswers = 0,
    this.examCount = 0,
    this.nickname = "",
  });

  @override
  List<Object?> get props =>
      [name, grade, password, isConfirmed, wPoints, marks];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'grade': grade,
      'password': password,
      'grade_id': gradeId,
      'email': email,
      'marks': marks,
      'w_points': wPoints,
      'confirmed': isConfirmed,
      'right_answers': rightAnswers,
      'wrong_answers': wrongAnswers,
      'exam_count': examCount,
      'nickname': nickname,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      grade: json['grade'] ?? "",
      password: json['password'],
      isConfirmed: json['confirmed'] ?? false,
      email: json["email"],
      marks: json["marks"] ?? 0,
      wPoints: json["w_points"] ?? 0,
      rightAnswers: json['right_answers'] ?? 0,
      wrongAnswers: json['wrong_answers'] ?? 0,
      examCount: json['exam_count'] ?? 0,
      nickname: json['nickname'] ?? "",
      gradeId: json["grade_id"] ?? "",
    );
  }
}
