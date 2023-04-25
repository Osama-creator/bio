class Mark {
  final String id;
  final String examName;
  final String grade;
  final String studentName;
  final int studentMark;

  Mark(
      {required this.examName,
      required this.studentMark,
      required this.id,
      required this.grade,
      required this.studentName});
  Map<String, dynamic> toJson() {
    return {
      'student_name': studentName,
      'exam_name': examName,
      'grade': grade,
      'student_mark': studentMark,
      'id': id,
    };
  }
}
