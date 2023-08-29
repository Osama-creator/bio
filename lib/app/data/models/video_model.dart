class VideoModel {
  final String title;
  final String url;

  VideoModel({required this.title, required this.url});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
    };
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      title: json['title'],
      url: json['url'],
    );
  }
}
