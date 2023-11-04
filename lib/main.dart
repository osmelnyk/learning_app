import 'package:flutter/material.dart';
import 'package:learning_app/presentation/pages/lesson_page.dart';
import 'package:learning_app/presentation/pages/module_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const ModulePage(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const ModulePage(),
        '/lesson': (BuildContext context) {
          final id = ModalRoute.of(context)!.settings.arguments as int;
          return LessonPage(moduleId: id);
        }
      },
    );
  }
}
