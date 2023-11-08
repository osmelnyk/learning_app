import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repository/hn_repository.dart';

part 'hacker_news_state.dart';

class HackerNewsCubit extends Cubit<HackerNewsState> {
  HackerNewsCubit() : super(HackerNewsInitial());

  final _hNRepository = HNRepository();

  Future<void> getTopStories() async {
    try {
      emit(NewsLoading());
      log('get news started');
      final news = await _hNRepository.getTopStories();
      emit(NewsLoaded(news));
    } catch (e) {
      emit(const NewsError('Failed to fetch top stories'));
    }
  }
}
