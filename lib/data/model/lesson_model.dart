class Lesson {
  int id;
  String? description;
  String? question;
  String? answer;
  String language;
  int moduleId;
  Lesson({
    required this.id,
    this.description,
    this.question,
    this.answer,
    required this.language,
    required this.moduleId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'question': question,
      'answer': answer,
      'language_code': language,
      'module_id': moduleId,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'],
      description: map['description'] ?? '',
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
      language: map['language_code'],
      moduleId: map['module_id'],
    );
  }

  @override
  String toString() {
    return 'Lessons(id: $id, description: $description, question: $question, answer: $answer, language: $language, moduleId: $moduleId)';
  }
}
