import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SelectAnswer extends StatefulWidget {
  final String? description;
  final dynamic answers;
  final bool answered;
  final Function(bool) isCorrect;

  const SelectAnswer(
      {super.key,
      this.description,
      this.answers,
      required this.isCorrect,
      required this.answered});

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
    _setCorrectAnswer();
  }

  void _setCorrectAnswer() {
    log(widget.answered.toString());
    if (widget.answered)
      setState(() => _selectedAnswers.addAll(_correctAnswers));
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
                    ? widget.answered
                        ? Colors.green
                        : Colors.yellowAccent
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
