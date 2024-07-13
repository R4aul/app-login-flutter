import 'package:flutter/material.dart';
import '../ui/views/login_view.dart';
import 'package:login_application/ui/views/register_view.dart';
import 'package:login_application/ui/views/list_diary_view.dart';
import 'package:login_application/ui/views/welcome_view.dart';

class Routes {
  static const String login = '/';
  static const String register = '/register';
  static const String welcome = '/welcome';
  static const String MyDiary = '/MyDiary';
  
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case login:
        return MaterialPageRoute(builder: (_) => LoginView()); 
      case register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case welcome:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => WelcomeView(userId: args['userID']));
      case MyDiary:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => ListDiaryView(userId: args['userID'])); 
      default:
        return MaterialPageRoute(builder: (_) => LoginView()); 
    }
  } 
}