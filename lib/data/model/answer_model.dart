import 'dart:convert';

class Answer {
  final String answer;
  final bool option;
  Answer({
    required this.answer,
    required this.option,
  });

  Answer copyWith({
    String? answer,
    bool? option,
  }) {
    return Answer(
      answer: answer ?? this.answer,
      option: option ?? this.option,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'answer': answer,
      'correct': option,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      answer: map['answer'] as String,
      option: map['correct'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) =>
      Answer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Answer(answer: $answer, option: $option)';

  @override
  bool operator ==(covariant Answer other) {
    if (identical(this, other)) return true;

    return other.answer == answer && other.option == option;
  }

  @override
  int get hashCode => answer.hashCode ^ option.hashCode;
}
