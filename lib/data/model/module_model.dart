import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Module extends Equatable {
  final int id;
  final String name;
  final String? description;
  final String language;
  final int courseId;
  final int? finishedLesson;
  const Module({
    required this.id,
    required this.name,
    this.description,
    required this.language,
    required this.courseId,
    this.finishedLesson,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'language_code': language,
      'course_id': courseId,
      'finished_lesson': finishedLesson,
    };
  }

  factory Module.fromMap(Map<String, dynamic> map) {
    return Module(
      id: map['id'],
      name: map['name'] as String,
      description: map['description'] ?? '',
      language: map['language_code'],
      courseId: map['course_id'],
      finishedLesson: map['finished_lesson'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Module(id: $id, name: $name, description: $description, language: $language, courseId: $courseId, finishedLesson: $finishedLesson)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      description ?? '',
      language,
      courseId,
      finishedLesson ?? 0,
    ];
  }

  Module copyWith({
    int? id,
    String? name,
    String? description,
    String? language,
    int? courseId,
    int? finishedLesson,
  }) {
    return Module(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      language: language ?? this.language,
      courseId: courseId ?? this.courseId,
      finishedLesson: finishedLesson ?? this.finishedLesson,
    );
  }
}
