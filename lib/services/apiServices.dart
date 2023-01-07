import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/html_escape.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

import '../utilities/articelsmodel.dart';

class ApiServices {
  // var newsQuery = "india";
  Future<List<Article>> getArticle(var newsQuery) async {
    final endPointUrl =
        "https://newsapi.org/v2/everything?q=$newsQuery&apiKey=716addab3492407aaa6516a8726cc119";
    Response res = await get(Uri.parse(endPointUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
