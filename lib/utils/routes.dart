import 'package:flutter/material.dart';
import '../ui/views/login_view.dart';
import 'package:login_application/ui/views/register_view.dart';
import 'package:login_application/ui/views/diaries/list_diary_view.dart';
import 'package:login_application/ui/views/welcome_view.dart';
import 'package:login_application/ui/views/diaries/create_diary_view.dart';
import 'package:login_application/ui/views/diaries/edit_diary_view.dart';

//importando modelos 
import 'package:login_application/models/user.dart';
import 'package:login_application/models/diary.dart';

class Routes {
  static const String login = '/';
  static const String register = '/register';
  static const String welcome = '/welcome';
  static const String MyDiary = '/MyDiary';
  static const String CreateDiary = '/CreateDiary';
  static const String EditDiary = '/EditDiary';
  
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
        final args = settings.arguments as Set<Object>; // Cambiado a Set<Object>
        User user = args.firstWhere((element) => element is User) as User; // Obtener el objeto User
        return MaterialPageRoute(builder: (_) => ListDiaryView(user: user));
      case CreateDiary:
        final args = settings.arguments as Set<Object>;
        User user = args.firstWhere((element) => element is User) as User;
        return MaterialPageRoute(builder: (_) => CreateDiaryView(user:user));
      case EditDiary:
        final args = settings.arguments as Set<Object>;
        Diary diary = args.firstWhere((element) => element is Diary) as Diary;
        return MaterialPageRoute(builder: (_) => EditDiaryView(diary: diary));
      default:
        return MaterialPageRoute(builder: (_) => LoginView()); 
    }
  } 
}