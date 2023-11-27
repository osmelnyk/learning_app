part of 'hacker_news_cubit.dart';

sealed class HackerNewsState extends Equatable {
  const HackerNewsState();

  @override
  List<Object> get props => [];
}

final class HackerNewsInitial extends HackerNewsState {}

class NewsLoading extends HackerNewsState {}

class NewsLoaded extends HackerNewsState {
  final List<dynamic> news;

  const NewsLoaded(this.news);

  @override
  List<Object> get props => [news];
}

class NewsError extends HackerNewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object> get props => [message];
}
