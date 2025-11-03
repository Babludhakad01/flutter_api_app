import 'package:flutter/material.dart';
import 'package:youtub_flutter_project/UI/screens/create_post.dart';
import 'package:youtub_flutter_project/UI/screens/get_posts.dart';
import 'package:youtub_flutter_project/UI/screens/auth_screens/login_page.dart';

class AppRoutes {
  static const String login = '/';
  static const String posts = '/posts';
  static const String createPost = '/create_post';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case posts:
        return MaterialPageRoute(builder: (_)=> PostScreen());

      case createPost:
        return MaterialPageRoute(builder: (_)=> CreatePostScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
