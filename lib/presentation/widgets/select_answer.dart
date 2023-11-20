import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SelectAnswer extends StatefulWidget {
  final String? description;
  final dynamic answers;
  final Function(bool) isCorrect;

  const SelectAnswer(
      {super.key, this.description, this.answers, required this.isCorrect});

  @override
  State<StatefulWidget> createState() => _SelectAnswerState();
}

class _SelectAnswerState extends State<SelectAnswer> {
  final List<int> _selectedAnswers = [];
  final List<int> _correctAnswers = [];

  @override
  void initState() {
    super.initState();
    _getCorrectAnswer();
  }

  void _getCorrectAnswer() {
    widget.answers!.asMap().forEach((index, value) {
      if (value.option) _correctAnswers.add(index);
    });
    _correctAnswers.sort();
  }

  void setAnswer(int optionIndex) {
    _selectedAnswers.contains(optionIndex)
        ? _selectedAnswers.remove(optionIndex)
        : _selectedAnswers.add(optionIndex);
    _selectedAnswers.sort();
    bool isCorrect = listEquals(_selectedAnswers, _correctAnswers);
    widget.isCorrect(isCorrect);
  }

  // bool checkAnswer() {
  //   bool isCorrect = listEquals(_selectedAnswers, _correctAnswers);
  //   return isCorrect;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.description ?? ''),
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.answers!.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                width: 2.0,
                color: _selectedAnswers.contains(index)
                    ? Color.fromARGB(255, 252, 195, 51)
                    : Colors.grey,
              )),
              onPressed: () {
                setState(() => setAnswer(index));
              },
              child: Text(widget.answers![index].answer),
            );
          },
        ),
      ],
    );
  }
}
