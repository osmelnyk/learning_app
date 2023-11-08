import 'package:flutter/material.dart';
import 'package:learning_app/presentation/pages/lesson_page.dart';
import 'package:learning_app/presentation/pages/module_page.dart';

import 'presentation/pages/error_page.dart';
import 'presentation/pages/hacker_news_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/profile_page.dart';

Map<String, WidgetBuilder> get routes {
  return <String, WidgetBuilder>{
    '/': (_) => const ModulePage(),
    '/login': (_) => const LoginPage(),
    '/profile': (_) => const ProfilePage(),
    '/lesson': (context) {
      final id = ModalRoute.of(context)!.settings.arguments as int;
      return LessonPage(moduleId: id);
    },
    '/news': (_) => const HackerNewsPage(),
    '/error': (context) {
      final message = ModalRoute.of(context)!.settings.arguments as String;
      return ErrorPage(errorMessage: message);
    },
  };
}

Route<dynamic>? unknownRoute(_) => MaterialPageRoute(
    builder: (_) => const ErrorPage(
          errorMessage: 'No page found!',
        ));

class RouteGuard extends NavigatorObserver {
  // for test purposes only
  final bool isAuthenticated = false;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    if (route.settings.name == '/profile') {
      // Check if the user is authenticated
      if (!isAuthenticated) {
        // If the user is not authenticated, navigate to the login screen
        Future.microtask(() => route.navigator!.pushReplacementNamed('/login'));
      }
    }
  }
}
