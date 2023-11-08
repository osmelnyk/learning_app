import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../model/hacker_news_model.dart';

class HackerNewsAPI {
  Future<List<HackerNews>> getTopStories() async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    var timeAgo = DateTime.now()
            .subtract(const Duration(days: 60))
            .millisecondsSinceEpoch ~/
        1000;
    final baseUrl =
        'http://hn.algolia.com/api/v1/search?tags=story&numericFilters=created_at_i>${timeAgo},created_at_i<${currentTime}&query=flutter';

    final response = await http.get(Uri.parse(baseUrl));
    final hits = jsonDecode(response.body)['hits'];
    final stories = <HackerNews>[];
    for (final Map<String, dynamic> hit in hits) {
      final story = HackerNews.fromJson(hit);
      stories.add(story);
    }
    return stories;
  }

  // Future<HackerNews> getItem(int id) async {
  //   final response = await http.get(Uri.parse('$baseUrl/item/$id.json'));
  //   final json = jsonDecode(response.body);
  //   return HackerNews.fromJson(json);
  // }
}
