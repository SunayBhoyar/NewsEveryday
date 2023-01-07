import 'package:url_launcher/url_launcher.dart';

class NewsList {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

// this is the news constructor
  const NewsList({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory NewsList.fromJson(Map<String, dynamic> json) {
    return NewsList(
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      content: json["content"],
      publishedAt: json["publishedAt"],
    );
  }
}
