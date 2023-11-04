class Module {
  int id;
  String name;
  String? description;
  String language;
  int courseId;
  Module({
    required this.id,
    required this.name,
    this.description,
    required this.language,
    required this.courseId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'language_code': language,
      'course_id': courseId,
    };
  }

  factory Module.fromMap(Map<String, dynamic> map) {
    return Module(
      id: map['id'],
      name: map['name'] as String,
      description: map['description'] ?? '',
      language: map['language_code'],
      courseId: map['course_id'],
    );
  }

  @override
  String toString() {
    return 'Module(id: $id, name: $name, description: $description, language: $language, courseId: $courseId)';
  }
}
