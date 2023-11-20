// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Progress {
  int moduleId;
  int? finishedLesson;
  Progress({
    required this.moduleId,
    this.finishedLesson,
  });

  Progress copyWith({
    int? moduleId,
    int? finishedLesson,
  }) {
    return Progress(
      moduleId: moduleId ?? this.moduleId,
      finishedLesson: finishedLesson ?? this.finishedLesson,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'module_id': moduleId,
      'finished_lesson': finishedLesson,
    };
  }

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      moduleId: map['module_id'],
      finishedLesson: map['finished_lesson'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Progress.fromJson(String source) =>
      Progress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'finished_lesson(moduleId: $moduleId, finished_lesson: $finishedLesson)';

  @override
  bool operator ==(covariant Progress other) {
    if (identical(this, other)) return true;

    return other.moduleId == moduleId && other.finishedLesson == finishedLesson;
  }

  @override
  int get hashCode => moduleId.hashCode ^ finishedLesson.hashCode;
}
