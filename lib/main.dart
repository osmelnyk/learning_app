import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/lesson/lesson_bloc.dart';
import 'bloc/module/module_bloc.dart';
import 'router.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ModuleBloc()),
          BlocProvider(create: (context) => LessonBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DART Leaning',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: routes,
          onUnknownRoute: unknownRoute,
          navigatorObservers:
              // guard protected routes
              [RouteGuard()],
        ));
  }
}
