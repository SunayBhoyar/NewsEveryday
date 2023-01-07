import 'package:flutter_first_application/utilities/news.dart';

class Article {
  NewsList? newsList;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  //Now let's create the constructor
  Article(
      {this.newsList,
      this.author,
      this.title,
      this.description,
      this.url,
      required this.urlToImage,
      this.publishedAt,
      this.content});

  //And now let's create the function that will map the json into a list
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      newsList: NewsList.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}
