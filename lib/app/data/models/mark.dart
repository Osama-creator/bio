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
}
