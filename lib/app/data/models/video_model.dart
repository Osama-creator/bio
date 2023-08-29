class VideoModel {
  String title;
  String url;
  final String id;

  VideoModel({required this.title, required this.url, required this.id});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'id': id,
    };
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }
}
