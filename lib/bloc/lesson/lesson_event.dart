part of 'lesson_bloc.dart';

sealed class LessonEvent extends Equatable {
  const LessonEvent();
}

class GetLessons extends LessonEvent {
  final int moduleId;
  final String language;

  const GetLessons(this.moduleId, this.language);

  @override
  List<Object> get props => [moduleId, language];
}
