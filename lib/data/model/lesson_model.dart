import 'dart:convert';
import 'answer_model.dart';

class Lesson {
  int id;
  String? description;
  String? question;
  dynamic answer;
  String type;
  String language;
  int moduleId;
  Lesson({
    required this.id,
    this.description,
    this.question,
    this.answer,
    required this.type,
    required this.language,
    required this.moduleId,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'description': description,
  //     'question': question,
  //     'answer': answer,
  //     'type': type,
  //     'language_code': language,
  //     'module_id': moduleId,
  //   };
  // }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    var answer;
    if (map['type'] == 'description') {
      answer = map['answer'] ?? '';
    } else if (map['type'] == 'select') {
      // log(map['answer']);
      answer = (json.decode(map['answer']) as List)
          .map((i) => Answer.fromMap(i))
          .toList();
      //answer = (map['answer']).map((i) => Answer.fromMap(i)).toList();
    }
    return Lesson(
      id: map['id'],
      description: map['description'] ?? '',
      question: map['question'] ?? '',
      answer: answer,
      type: map['type'],
      language: map['language_code'],
      moduleId: map['module_id'],
    );
  }

  @override
  String toString() {
    return 'Lessons(id: $id, description: $description, question: $question, answer: $answer, type: $type, language: $language, moduleId: $moduleId)';
  }
}
