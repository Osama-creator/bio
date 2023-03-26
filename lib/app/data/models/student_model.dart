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
