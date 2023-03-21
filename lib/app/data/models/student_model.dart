class Studen {
  final String name;
  final String id;
  final int absence;

  Studen({required this.name, required this.id, required this.absence});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'absence': absence,
    };
  }
}
