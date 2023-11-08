// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HackerNews {
  final String title;
  final int createdAt;
  final int points;
  final String url;

  HackerNews({
    required this.title,
    required this.createdAt,
    required this.points,
    required this.url,
  });

  factory HackerNews.fromJson(Map<String, dynamic> json) {
    return HackerNews(
      title: json['title'],
      points: json['points'],
      createdAt: json['created_at_i'],
      url: json['url'] ?? '',
    );
  }
}
