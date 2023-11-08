import 'package:flutter/material.dart';
import 'router.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
