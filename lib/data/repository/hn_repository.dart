import 'dart:developer';

import '../datasource/Hacker_news_api.dart';
import '../model/hacker_news_model.dart';

class HNRepository {
  final HackerNewsAPI api = HackerNewsAPI();
  Future<List<HackerNews>> getTopStories() async {
    // log(_hackerNewsAPI.getTopStories().toString());
    return api.getTopStories();
  }
}
