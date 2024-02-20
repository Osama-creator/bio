class Mark {
  final String? id;
  final String examName;
  final String grade;
  final String studentName;
  final String? email;
  final int studentMark;
  final int examMark;

  Mark(
      {required this.examName,
      required this.studentMark,
      this.id,
      required this.grade,
      this.email,
      required this.examMark,
      required this.studentName});
  Map<String, dynamic> toJson() {
    return {
      'student_name': studentName,
      'exam_name': examName,
      'grade': grade,
      'student_mark': studentMark,
      'exam_mark': examMark,
      'email': email ?? "",
      'id': id,
    };
  }

  factory Mark.fromJson(Map<String, dynamic> json) {
    return Mark(
      id: json['id'],
      examName: json['exam_name'],
      grade: json['grade'],
      studentName: json['student_name'],
      email: json['email'],
      studentMark: json['student_mark'],
      examMark: json['exam_mark'],
    );
  }
}
