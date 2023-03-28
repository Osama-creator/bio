class GradeItem {
  final String name;
  final String id;

  GradeItem({
    required this.name,
    required this.id,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}
