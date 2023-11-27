import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/lesson/lesson_bloc.dart';
import '../../bloc/module/module_bloc.dart';
import '../../data/model/lesson_model.dart';
import '../../data/model/progress_model.dart';
import '../widgets/select_answer.dart';
// import 'package:markdown/markdown.dart' as md;
import 'package:markdown_widget/markdown_widget.dart';

class LessonPage extends StatefulWidget {
  final Map args;
  const LessonPage({super.key, required this.args});

  @override
  State<StatefulWidget> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  GlobalKey globalKey = GlobalKey();
  int _currentPage = 0;
  bool _isCorrect = false;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _initialPage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _initialPage() {
    final int finishedLesson = widget.args['finishedLesson'];
    _pageController = PageController(initialPage: finishedLesson);
    _currentPage = finishedLesson;
  }

  void _goToPreviousPage(BuildContext context) {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToNextPage(BuildContext context, int length, int savedProgress) {
    // Set lesson position to module
    final Progress progress = Progress(
      finishedLesson: _currentPage + 1,
      moduleId: widget.args['module_id'],
    );

    if (_currentPage + 1 > savedProgress) {
      context.read<ModuleBloc>().add(SetProgress(progress));
    }

    _isCorrect = false;
    // If the current page is not the last one, go to the next page
    (_currentPage < length - 1)
        ? _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          )
        : Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LessonBloc>(context)
        .add(GetLessons(widget.args['module_id'], 'en'));
    return Builder(builder: (context) {
      final lessonState = context.watch<LessonBloc>().state;
      final moduleState = context.watch<ModuleBloc>().state;
      int savedProgress = 0;
      if (moduleState is ModulesLoaded)
        savedProgress =
            moduleState.modules[widget.args['module_id'] - 1].finishedLesson!;

      if (lessonState is LessonLoaded) {
        final length = lessonState.lessons.length;
        return Scaffold(
          appBar: AppBar(
              title: _buildStepperNavigation(length, savedProgress),
              leading: (_currentPage > 0)
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => _goToPreviousPage(context),
                    )
                  : const SizedBox(),
              actions: [
                IconButton(
                  icon: const Icon(Icons.restart_alt),
                  onPressed: () {
                    final Progress progress = Progress(
                      finishedLesson: 0,
                      moduleId: widget.args['module_id'],
                    );
                    context.read<ModuleBloc>().add(SetProgress(progress));
                    _pageController.animateTo(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  },
                ),
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ]),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: length,
                    onPageChanged: (int page) {
                      setState(() => _currentPage = page);
                    },
                    itemBuilder: (context, index) {
                      final Lesson lesson = lessonState.lessons[index];
                      final bool answered = savedProgress > index;
                      return Stack(children: [
                        _lessonBody(lesson, answered),
                        Positioned.fill(
                          bottom: 10,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FloatingActionButton(
                              onPressed: () {
                                log('$index: $savedProgress');

                                if (savedProgress > _currentPage) {
                                  _goToNextPage(context, length, savedProgress);
                                } else if (lesson.type == 'select' &&
                                    _isCorrect) {
                                  _goToNextPage(context, length, savedProgress);
                                } else if (lesson.type == 'description') {
                                  _goToNextPage(context, length, savedProgress);
                                }
                              },
                              child: const Icon(Icons.navigate_next_rounded),
                            ),
                          ),
                        ),
                      ]);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return const Center(
        child:
            CircularProgressIndicator(), // Show loading indicator while fetching data
      );
    });
  }

  Widget _lessonBody(Lesson lesson, bool answered) {
    switch (lesson.type) {
      case 'description':
        return MarkdownWidget(
            data: '${lesson.description}',
            config: MarkdownConfig(configs: [
              const PreConfig(language: 'dart'),
            ])
            );
      case 'select':
        return SelectAnswer(
          answered: answered,
          description: lesson.description,
          answers: lesson.answer,
          // checked:
          isCorrect: (isCorrect) {
            setState(() => _isCorrect = isCorrect);
          },
        );
      default:
        return Text(
          '${lesson.description}',
          style: const TextStyle(fontSize: 20),
        );
    }
  }

  Widget _buildStepperNavigation(int length, int savedProgress) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final Color dotColor;
        index < savedProgress
            ? dotColor = Colors.green
            : dotColor = Colors.grey;
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 5,
            backgroundColor: _currentPage == index
                ? Theme.of(context).primaryColor
                : dotColor,
          ),
        );
      }),
    );
  }
}
