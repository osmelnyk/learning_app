import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/lesson/lesson_bloc.dart';

class LessonPage extends StatefulWidget {
  final int moduleId;
  const LessonPage({super.key, required this.moduleId});

  @override
  State<StatefulWidget> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  int _currentPage = 0;

  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonBloc()..add(GetLessons(widget.moduleId, 'en')),
      child: BlocBuilder<LessonBloc, LessonState>(builder: (context, state) {
        if (state is LessonLoaded) {
          final length = state.lessons.length;
          return Scaffold(
            appBar: AppBar(
                title: _buildStepperNavigation(length),
                leading: (_currentPage > 0)
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: _goToPreviousPage,
                      )
                    : const SizedBox(),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ]),
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: length,
                    onPageChanged: (int page) {
                      setState(() => _currentPage = page);
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          '${state.lessons[index].description}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: (_currentPage < length)
                ? FloatingActionButton(
                    onPressed: _goToNextPage,
                    child: const Icon(Icons.navigate_next_rounded),
                  )
                : const SizedBox(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        }
        return const Center(
          child:
              CircularProgressIndicator(), // Show loading indicator while fetching data
        );
      }),
    );
  }

  Widget _buildStepperNavigation(int length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 5,
            backgroundColor: _currentPage == index
                ? Theme.of(context).primaryColor
                : Colors.grey,
          ),
        );
      }),
    );
  }
}
