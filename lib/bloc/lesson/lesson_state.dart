part of 'lesson_bloc.dart';

sealed class LessonState extends Equatable {
  const LessonState();
}

final class LessonInitial extends LessonState {
  @override
  List<Object> get props => [];
}

final class LessonLoading extends LessonState {
  @override
  List<Object> get props => [];
}

final class LessonLoaded extends LessonState {
  final List<Lesson> lessons;
  const LessonLoaded(this.lessons);

  @override
  List<Object> get props => [lessons];
}

final class LessonLoadingError extends LessonState {
  final String message;
  const LessonLoadingError(this.message);
  @override
  List<Object> get props => [message];
}
