import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_app/data/model/lesson_model.dart';
import 'package:learning_app/data/repository/db_repository.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(LessonInitial()) {
    on<GetLessons>((event, emit) async {
      emit(LessonLoading());
      try {
        final lessons =
            await DBRepository().getLessons(event.moduleId, event.language);
        log(lessons.toString());
        emit(LessonLoaded(lessons));
      } catch (e) {
        log(e.toString());
        emit(LessonLoadingError(e.toString()));
      }
    });
  }
}
